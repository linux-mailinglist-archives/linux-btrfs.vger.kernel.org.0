Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1313B9E10
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhGBJYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 05:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhGBJYs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Jul 2021 05:24:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 108BD610FB
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625217737;
        bh=2KyB1yL2W/K/VQY8aOu1YuWig9PKkOf/fn09WDx9eTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RfP+lG06S8WxcIp9At/sssk5a8CDnZTqS/JIN2uJgVOOj9hrdPMXEhg/McD1FQO4y
         XHG9sv0kZ4djdn3cTGKVkD/ZubamfDNEKOqy6AlWsWu22AnzhWhSWgFYecPvaSDsdT
         lToV6YIWsBKo+LYQ9SgSePcW6flkyQihZTJ9lspMD228oYrPWdIAKvvn5MhxINHAru
         0evPGhEGAghY3TWAt3lHYk2v7RMomfDCpDODy8XNlX1SoEs8Ahqk/oobYIe+yE+51S
         mYsOhINUrLsjB66WbtUdONE1bowHwocgwIGhz0BeVnBmQsJ47MM04YGGcEUQleThYe
         DC9l6gQls9iWQ==
Received: by mail-qt1-f171.google.com with SMTP id g3so6139509qth.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 02:22:17 -0700 (PDT)
X-Gm-Message-State: AOAM5332n/2gztv48Q5WAM/tggHAK40VuHtkV0iqorJao68MKN09AkNc
        Rit9ejPzSNmj+9vInJ2wTVTsFiIzkOfSd7hmNmM=
X-Google-Smtp-Source: ABdhPJyFmZiXJvv2wkK1XrnK83klLmdKPDoExJjtAqWbW9mD1q9HOhKILlwJZWG/1bHHbc/RI9GfvIV+hlxosxTTd+o=
X-Received: by 2002:a05:622a:1a23:: with SMTP id f35mr4214604qtb.21.1625217736306;
 Fri, 02 Jul 2021 02:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624973480.git.fdmanana@suse.com> <6a715978a2539344e0c795754817746e06b73438.1624973480.git.fdmanana@suse.com>
 <d3a3fa99-b55d-7bae-4fdb-f3b2f5c7d98f@suse.com>
In-Reply-To: <d3a3fa99-b55d-7bae-4fdb-f3b2f5c7d98f@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 2 Jul 2021 10:22:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7hkgu+BR8v7TVx+e0CCPaNp27CcFwS1x-FQ-LpTVOe+w@mail.gmail.com>
Message-ID: <CAL3q7H7hkgu+BR8v7TVx+e0CCPaNp27CcFwS1x-FQ-LpTVOe+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: rework chunk allocation to avoid exhaustion of
 the system chunk array
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 2, 2021 at 9:52 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 29.06.21 =D0=B3. 16:43, fdmanana@kernel.org wrote:
> > |However that commit also introduced a deadlock where a task in phase 1
> > of the chunk allocation waited for another task that had allocated a
> > system chunk to finish its phase 2, but that other task was waiting on
> > an extent buffer lock held by the first task, therefore resulting in
> > both tasks not making any progress. That change was later reverted by a
> > patch with the subject "btrfs: fix deadlock with concurrent chunk
> > allocations involving system chunks", since there is no simple and shor=
t
> > solution to address it and the deadlock is relatively easy to trigger o=
n
> > zoned filesystems, while the system chunk array exhaustion is not so
> > common. |
>
> nit: Wouldn't the deadlock constitute of the task in phase1, holding
> chunk_mutex sleep on chunk_reserve_wait and having set
> space_info->chunk_alloc =3D 1 and this in turn causes task in phase 2 to
> to deadlock on chunk_mutex in btrfs_alloc_chunk due to
> btrfs_create_pending_block_groups (phase2) happening with chunk_mutex
> unlocked BUT chunk_reserve_wait still not woken up ? Your previous patch
> explains this situation but this paragraph seems to mention extent
> buffer locks which I don't think are involved in the deadlock.

Yes, that's one of the cases, when both tasks are allocating chunks of
the same type.
The other case is regarding extent buffer locks as mentioned there
Indeed I didn't go into too much detail there, as one patch refers to
the other and avoids repeating too much.
