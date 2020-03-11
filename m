Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C575B181FD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgCKRo6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:44:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41927 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgCKRo5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:44:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id b5so2911107qkh.8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ttmCiMbEDwtGtvoj06GNeVWmW/kH5G9yg5OKv20SvkE=;
        b=TGzbji5PbDVu+/E5aCG3AFPXPLNODiCdVgG2r82ug0+LKTYHbWR+BvYih4YJ25bCtb
         Ht8H4j2lquSR8IVljKsF9qRZaSOnDTiuE4vurak4W9poIXHRxA+CjkmR76Y11fhQIbIQ
         /4OXjNjfs9xnrlE929ttp+wB0iMKEDkG8Q2TrqUt5aseFT9cVm4cv4ySa0V6TxKeSaIb
         BTOIrRj9B5dsxixC5xTW+fPMUcKXwNVazGMlRpOt5tf4KyxOKc44M69YRrwUHrDgscFd
         kZuOOJyk5UVG4m4VWLH2/Cz3AOE5L4ICtHTgWO40FPsCPFuOMjgh4m1zAK38FkpJDmtM
         14kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttmCiMbEDwtGtvoj06GNeVWmW/kH5G9yg5OKv20SvkE=;
        b=rN5QiPbGuc7B/2h3UCIysyU0Pz7uPR769foNgdrFCotmWeo5lFFJLiC/0HDe5317Ig
         DYI5KgIYNS4tVnhQDMZIbykCPeSvLHeaNlbyjt4PxXRXlk3AHO2z7o6Vu6fiLRK9Pspl
         ZS2NKg+PYyldMrtdeZOd8T/6jo9ZjI2kVrK3N3UsVrA3+EL15olLZYhnYqHGHL3Q57Uq
         nUPUfarpCDtabsHevyqf55c4YtDURuhePe7J9FmDHPfzqMSurXNwC1s/qijWdppErr0R
         chta/ho+sPOuoQvnRZ8shdKCubwed8S6ox0AqjWY+D3VAdfsOB6hvejgQg/stmvV1e1O
         nz8A==
X-Gm-Message-State: ANhLgQ24sidWqrwd9Fh8O9a72U0o72qsIU6brQTqz3SLxEpIhFlsVLon
        0KL8+2Wy1S+Nxrmm8eU3QLK7YrBNqKM=
X-Google-Smtp-Source: ADFU+vup+xI+07GLK89LpGQ9snw2AIVR6JbOi3XSzMzHMLOJC65Pax1fBNXamtTCSHbX6ZAFgbXfOg==
X-Received: by 2002:a05:620a:13f5:: with SMTP id h21mr3801350qkl.426.1583948695848;
        Wed, 11 Mar 2020 10:44:55 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w11sm22044896qti.54.2020.03.11.10.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:44:55 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Btrfs: make ranged fsyncs always respect the given
 range
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200309124108.18952-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6fd4856c-ca48-0cca-f5e1-3208a55ea033@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:44:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309124108.18952-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 8:41 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset fixes a bug when not using NO_HOLES and makes ranged fsyncs
> respect the given file range when using the NO_HOLES feature.
> 
> The bug is about missing file extents items representing a hole after doing
> a ranged fsync on a file and replaying the log.
> 
> Btrfs doesn't respect the given range for a fsync when the inode's has the
> "need full sync" bit set - it treats the fsync as a full ranged one, operating
> on the whole file, doing more IO and cpu work then needed.
> 
> That behaviour was needed to fix a corruption bug. Commit 0c713cbab6200b
> ("Btrfs: fix race between ranged fsync and writeback of adjacent ranges")
> fixed that bug by turning the ranged fsync into a full ranged one.
> 
> Later the hole detection code of fsync was simplified a lot in order to
> fix another bug when using the NO_HOLES feature - done by commit
> 0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync when
> using NO_HOLES"). That commit now makes it easy to avoid turning the ranged
> fsyncs into non-ranged fsyncs.
> 
> This patchset does those two changes. The first patch fixes the bug mentioned
> before, patches 2 and 3 are preparation cleanups for patch 4, which is the
> one that makes fsync respect the given file range when using NO_HOLES.
> 
> V3: Updated patch one so that the ranged is set to full before locking the
>      inode. To make sure we do writeback and wait for ordered extent
>      completion as much as possible before locking the inode.
>      Remaining patches are unchanged.
> 
> V2: Added one more patch to the series, which is the first patch, that
>      fixes the bug regarding missing holes after doing a ranged fsync.
> 
>      The remaining patches remain the same, only patch 4 had a trivial
>      conflict when rebasing against patch 1 and got its changelog
>      updated. Now all fstests pass with version 2 of this patchset.
> 
> Filipe Manana (4):
>    Btrfs: fix missing file extent item for hole after ranged fsync
>    Btrfs: add helper to get the end offset of a file extent item
>    Btrfs: factor out inode items copy loop from btrfs_log_inode()
>    Btrfs: make ranged full fsyncs more efficient
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series.  Thanks,

Josef
