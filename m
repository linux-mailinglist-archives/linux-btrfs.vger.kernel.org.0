Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE6658803
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 01:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiL2AIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 19:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiL2AIU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 19:08:20 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76C14D00;
        Wed, 28 Dec 2022 16:08:19 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i12so11956620qvs.2;
        Wed, 28 Dec 2022 16:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEqtTwvMMsN+kiKq4Md/C7M7dS80KVmeITunwk8+FbI=;
        b=DkwXQESyG5omlqK4NSe7tHvQy/fgu/Bt2w+zC36ggTaRREDbYJS7B6q1nfa47Rv6qm
         by1j1GiyLX3P4eEs5g78121ns7OZdkGlUrsRrpflGiqmXNDhSZ+B7NIJ9mdcjn686XZC
         RZyC7jz55GGodXKWmKkn4OYIZWldiJZTycw5a6xrFAw185hGSsI9RCNfQYYeXsRoyh7Q
         FfnW01m7WLGMEegtNHFoVOR/N2hPsNIsLGtNGB7OVH5sUjX+yDSqAPniBEK3AxstiMco
         7WyW5XhhGNqexajFd7uH9W3utuj0RGMVoWURGeykBA2eWCJm/lRXY0WHZ/NKaZLRkcJ/
         S4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEqtTwvMMsN+kiKq4Md/C7M7dS80KVmeITunwk8+FbI=;
        b=EMM+o23rG/X+p1fKL+tfVoUVmt+uhfbb+V+c+p6jntaJP3A/fd2AonuYnFkCoqBdFm
         S15ksuCHzLlY/Z7dFRH0XaOD4O33oiKndTzbnpUwfm3HaffxRdU5iNej4xILhQFQZIiP
         5lELB8aMKwh9xnYMMaC2kV1DnchHnpzdgMru6c5UdJ2DasdIp0MyrEib2fptp/ZLUvXq
         TR750n9ORUW7/wgpDLxN9wqqU/Ssg79F/FoyL482U5EOHYzfMRyrcGvBwrFkWtjZggdx
         4HFIoEjmOubmb3q+NZEqk0CM+Un+u9FhgbsJFRB6+IfhD+O1qgbNbQ0nxf0ICie9Ufmk
         MCLg==
X-Gm-Message-State: AFqh2kpnnVmNggMjSGMASHdYnLE7tcNG1955D9cuZOhzGJzzwLbTX9di
        AVyxnBbO5z9AUIuKJ8nB6w56MJiM4QccT/2yDYiEChgzA1OWDWH3nss=
X-Google-Smtp-Source: AMrXdXuW9SMiwEH3dpCDZoKzYlPBrByUnMVPnPiUETckuv+3LSyOuqUzU0wnwA5ON6cRhFx3BLjtLCxWaWpJw4/5Cd0=
X-Received: by 2002:a05:6214:15d3:b0:4df:2bdc:14f3 with SMTP id
 p19-20020a05621415d300b004df2bdc14f3mr925417qvz.34.1672272498179; Wed, 28 Dec
 2022 16:08:18 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com> <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com> <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com> <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
 <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com> <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
 <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com> <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
 <7d2edc1d-922b-763c-3122-0a6f81c3454e@suse.com> <CABXGCsOq56Qjq+-Bnfbe7ZvhfjSs204cbc8VFG7b+J2Ncss0ng@mail.gmail.com>
 <fd0a0bfe-5c67-fd95-b17c-78a14c63bea6@gmx.com> <CABXGCsMev+96zixic3=5cLgzMfZKcJE-zOLPrc3-vTrrDZQDig@mail.gmail.com>
 <de8fb932-2934-7ad2-112a-a9a2e63b532d@gmx.com>
In-Reply-To: <de8fb932-2934-7ad2-112a-a9a2e63b532d@gmx.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 29 Dec 2022 05:08:06 +0500
Message-ID: <CABXGCsMN-wviuURYkGXxr_d3BKtW3vyYhQ3Kpd7ZVo-Yr4gBvQ@mail.gmail.com>
Subject: Re: [6.2][regression] after commit 947a629988f191807d2d22ba63ae18259bb645c5
 btrfs volume periodical forced switch to readonly after a lot of disk writes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 29, 2022 at 4:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Are you using qgroup? If so it may be worthy trying disabling qgroup.

I do not use quota.
And looks like my distro does not use quita by default.
=E2=9D=AF btrfs qgroup show -f /
ERROR: can't list qgroups: quotas not enabled

> But for newer kernel, qgroup hang should only happen when dropping large
> snapshot, I don't know if podman pull would cause older snapshots to be
> deleted...

It is not a regression, it also happened on older kernels.
But it is really annoying when the browser process waits when "podman
pull" writes changes to disk.
In fact, I have been waiting for 5 years for caching of slow HDDs by
using the cache on the SSD, but apparently I can=E2=80=99t wait.
And I started slowly buying expensive large SSDs to replace the big
HDD. I still can=E2=80=99t find time to connect D5 P5316 30.72 Tb to the
primary workstation.
I want to make a video review of it. I understand this is an expensive
solution and not suitable for everyone, unlike an affordable SDD
cache.

--=20
Best Regards,
Mike Gavrilov.
