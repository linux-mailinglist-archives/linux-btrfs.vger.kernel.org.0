Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8625A029
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIAUqj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 16:46:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE79C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 13:46:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q9so2412245wmj.2
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mod1v9vHrjybu+RimYP+nn/epXOixSqv007CkTAWdoQ=;
        b=hQjhBllTh0FpCFCoOhavrw5jbDEneaNFTCP9jn6DimaAGKK2CYrpuxl21dpklH6o1+
         gILMJXTCr+7g+TECiEagfnqf8Llt2dZL5JWewR4pfXMv2j9I63qYOAvb21vYszO+BKyr
         JxupGOwH4ITaLPqnRZOlFkMnuUxXCMqvaqws2ozPVMEI29+SbqcUXR4yTKAJBkXuk5ii
         DHviUbEKo6PL8lVLHhTAz+nfCPoQjimQt7TaaMYlgGUyujmHopreMTyIZ9riPc7UJkEX
         1EHm6XMJcaDStBYYLBUZSWhFYc0fh+hM+0cchv+4KmJVQqrNpeeR2kPHn7iQ091bVovE
         y+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mod1v9vHrjybu+RimYP+nn/epXOixSqv007CkTAWdoQ=;
        b=kHHua/dpUr4HlnNX4CVPyMHmosribPseEI2VskIBkK19+I8aw03Zm0mYte5lP5D/3g
         VH4E2Oh15/IKVbpxItAAfsyd8NV76Gspn4f805L5RFcmaEV9bZmCdn29291J67IAdC/Z
         eOALNPGjp58yZuEVIJi1bt/jM5E0fzI7WFa4l++yJ7k8UBW4Ove58cupS4HDTiOoj5Fl
         q8Of7Xjs7c/sen8Ls59IY2L7EUNKr3cOL5SXIIcFjja2zVDT/o19PD7Eq4sqTsRFe1Pr
         RJl0O9dMws7hXk/x2mlJ8ClvVKWMdnjPJ4S3onhblcIwPth3c+y/9hfoF9Ew+hpXArNJ
         6CPg==
X-Gm-Message-State: AOAM533RQUccYl2YPEyWG0mh2nrFRIhiWutHCNLorhT0MqgTi3Tqg/9g
        bLMwVT9X/fdvoFGp3SOFJHwpZkSfkVOXzQ3B87csSTTqvnCmIQ==
X-Google-Smtp-Source: ABdhPJwKnzoRUN0cB+7S8MHOUBp3OhVloop/FBs3t6VB92ZOIYm4qZQVeVBdtX7IZ1ErkLPBqIFrZQO2jYDkwYwtggE=
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr3430649wmh.168.1598993196264;
 Tue, 01 Sep 2020 13:46:36 -0700 (PDT)
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
Date:   Tue, 1 Sep 2020 14:45:46 -0600
Message-ID: <CAJCQCtQNZQCuTGEE+cDoiH_7BhGKMxnsJK-QgpPUVP24OmpDUg@mail.gmail.com>
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

Yes, it's a Btrfs logical address so it can be a value larger than the
physical size of the file system.

Try command 2 again and see if that extent and block are still there.
It should work.

-- 
Chris Murphy
