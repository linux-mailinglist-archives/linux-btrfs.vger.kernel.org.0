Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A919925B1D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIBQg0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBQgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 12:36:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17462C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 09:36:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so28675wmh.4
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lh6DVfNtnVaX0caqwX5IA9gtpnMswZlSO6sTLK5aaJE=;
        b=ymMT44eWRdxM0ApIqrlDOT5G15LdyOByHVJdrfhKW23CAdeH5KBXvFhSLmAXRdoAeW
         Duhh1s+2/Hip+Ltwomu2CpkMfMF8Ps+7ODww94rSvz5IwLm28pNqCOQ1UjwZxRGD0pCB
         +7hUsK+2U1KM0O17lyrmWLvdLpvqwxzqw964gGqo/gPtL2lhyQNi4NJDDdDcKRqWEIqs
         qruPN5WinJGhqr7s9xo0nBdl1Zk5+7izAbBQrjOvECuofMB04F0MT+D5B+a+O+z72Jia
         H6EyvFwp9u+OBlfqLWdCaw0Q6CFfeDsRl8TGardqRngJb2dY3LUXCXqeDUHE22V8341j
         naTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lh6DVfNtnVaX0caqwX5IA9gtpnMswZlSO6sTLK5aaJE=;
        b=D6GXXGgoP51wVSTmNU8/w1CskuxLyVVKv0SD4H7Dox7YqyMNt/REKUDI4+WOmeEtpc
         darAzz1rdU58NYmXRC15ZcIIhaoYPuE+4guTAL9ZZzrwfpe0SlaSrmHqAEnXeICKaBPN
         vD40ILETaMwoPEusnL+9NqPPV2onRb2zHL3MCYRc59Qx87rIwuUq71WGacpweTcRn5i1
         fWBEMpfdiyoGGKnG0YzMb4dW4DPsj09k01MgeMK5RWhMdD4r05f4/vE+v0J3+3yH4DF2
         xTS4JzQCHO5KWrF/++n1YKrLBvfZrjHLPeZbL8rRAIkLJsY0NdT+3YaEvXNUKRSkY5DK
         5vYw==
X-Gm-Message-State: AOAM530vhlaPUpHks2Vj2pcD63m1CmVC/0809srs2iUe5FBXcOmaXxbg
        /EudYxgTZFi1kGWpgobxjdk6ymuG/lsh7KCyV4jygA==
X-Google-Smtp-Source: ABdhPJyhOzvjg/+TlPWHnzMdzQHP/bDTA+N9MPT8IRQ7TLoiXiJTFZqKTMhYvEaPkBnQX2rFqvEGJzwlj1OhdsQyK/0=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr1557770wmc.182.1599064583554;
 Wed, 02 Sep 2020 09:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
 <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com>
 <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com>
 <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com>
 <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com>
 <CAJCQCtSB3QrA74tAH=_Fa-f8WWXJUANgt1_0PRbLcDUgBho-GQ@mail.gmail.com>
 <OpaR4q6qHHmnUMeRS6_aPu4cgwiwIXFIuVFcCyTJ5tR96gqj0wjAJDnspXY0SydaKgAD79u8CxC_8-XiSRkL7kkDf-Oqmz5-awgn4g4-eqw=@protonmail.com>
 <CAJCQCtRzKvPr=wipKcg_s4mgPjHB-W10sEJM8F_cC_GgFmA=ng@mail.gmail.com>
 <JOmCIgo1pxy4fmswJRB8Y5jH6okgELkDeBUKOcoaxsFv5uSIEyJnw2M03lY3mLNYfFVKpZJTB76nmFwHcuuSm8bHUWtHFNtDg-8M84ZD6Lc=@protonmail.com>
 <FNHuKE6SxKXKEVcOcQsBsj4Beunsv7CSnCpW8TGTrI_SzKH91Xlj_DnzUIWvfYvm1Wvrf-50fdnKMSNytNVdaUjada39LSjnYXETE8oiZTs=@protonmail.com>
In-Reply-To: <FNHuKE6SxKXKEVcOcQsBsj4Beunsv7CSnCpW8TGTrI_SzKH91Xlj_DnzUIWvfYvm1Wvrf-50fdnKMSNytNVdaUjada39LSjnYXETE8oiZTs=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 2 Sep 2020 10:35:32 -0600
Message-ID: <CAJCQCtQz4Xe_GpnW1FM51nc+1kcg5Kb63WKaypqFJO7uiKwthg@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 1, 2020 at 11:31 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> I wonder how can "1192747888640" be a byte number if it's more than 1TiB, and I have only 476GiB partition. Is the 4096 multiplier surely correct for my filesystem?
>

On second thought, it's probably easier if you just make an image
(metadata only). It'll need to be unmounted.

btrfs-image -ss -c4 -t4 /dev/nvme /path/to/file

-ss will scrub the file names. From prior output about this fs, it
looks like the resulting file will be around 100M. You can email me
the URL to the file offline.

Thanks,

-- 
Chris Murphy
