Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6CF410ECD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhITDdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhITDdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 23:33:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60778C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Sep 2021 20:32:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 194so13065517qkj.11
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Sep 2021 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=74zEZJGe4DkF7oRt3mAdwqvsdFUcWIVcHs8OHL7Hcew=;
        b=ULxDvp1ws7iC6+olrIKy1ccs5wBhD9PMlIiBetXC5TnV5w2L36OLGgRwHkJzKpWk+q
         6GRVAUcjoKj3NsYmuNRsJhGSnkgyOUcWUxbo1p2KJ1Wrf6Zal5tEf2GPjNRcJxg8GD3j
         11ggRFVG/zPhPcWTHmYVIHLX2k8HibO4vde2mAlmWR5zJA41w+7PtdKkzsqC7VJRE5oe
         lfST5AL5PxxOaKnZlWeuif86WSJJ2RVU6d35DTpitxbOca8XLaaRUVo+KX7iUI3arPv7
         lAG9Vl67PEkVpeSjM7McdxxHKa51fg0AJ30GnsWXp0xOmNPP8+TIIvQKqzkReP9b+Wv4
         hriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=74zEZJGe4DkF7oRt3mAdwqvsdFUcWIVcHs8OHL7Hcew=;
        b=FQXPArwaH7p9nZ3Bsb0kRnehteroAnkSvS+RoXqNXUUPjN2sxJ8rwj/EOcwx/4UuYF
         FAoJiQcRi3hC/Tktk4yLCVXbkhEpDN5pmS8939aT5BBu681cMbqQ/jJBnm/LPCbUxf0G
         zu8NiJq3spsVLdNYIhronNSuwguZXLcQLaEpCD2BhXzn3sM+osIk7uDxh8YiA3m9YA2o
         2BI30j93gLCDuBntHgb9xTClRZEC0XQFfQO0DrygnxYo5VnHW5OGNZ1/Br3IKnqpjHJK
         oNe8HCgI6syoKFzU1D+cX2qkQfHFl0A2+fn7ejtycd3BkkF2jowF3KyxXSgLrjh9cX2J
         Xh/w==
X-Gm-Message-State: AOAM530ZUAz5qw92paAoaNgxujhjbpWZqMIQkQ8gViIQ/rqtZcMxnG/Q
        OxPikHArJFK82vEQRC6J43v+uePJamYtqukPdRZtfgm1V7LnRA==
X-Google-Smtp-Source: ABdhPJwwu6LPlaNwSpX/VESTQ7jAj+iXrADC9ONwG7Xrpusd7uI4JCw4Qx4YA9hYuCq4dvrKoF33E36A2aKiXO1cR/c=
X-Received: by 2002:a25:ad1f:: with SMTP id y31mr27113202ybi.437.1632108737437;
 Sun, 19 Sep 2021 20:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <9809e10.87861547.17bfad90f99@tnonline.net> <52c5e29d-0ac3-e962-c915-b313d28c05d1@gmx.com>
In-Reply-To: <52c5e29d-0ac3-e962-c915-b313d28c05d1@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 19 Sep 2021 21:32:01 -0600
Message-ID: <CAJCQCtQQieOB4H5j-0mreGhzb0xJj2HtMOAJ=m2gTb79-eMR8w@mail.gmail.com>
Subject: Re: Select DUP metadata by default on single devices.
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 18, 2021 at 5:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/19 05:38, Forza wrote:
> > Hello everyone,
> >
> > I'd like to revisit the topic I opened on Github(*) a year ago, where I=
 suggested that DUP metadata profile ought to be the default choice when do=
ing mkfs.btrfs on single devices.
> >
> > Today we have much better write endurance on flash based media so the a=
dded writes should not matter in the grand scheme of things. Another factor=
 is disk encryption where mkfs.btrfs cannot differentiate a plain SSD from =
a luks/dm-crypt device. Encryption effectively removes the possibility for =
the SSD to dedupe the metadata blocks.
> >
> > Ultimately, I think it is better to favour defaults that gives most use=
rs better fault tolerance, rather than using SINGLE mode for everyone becau=
se of the chance that some have deduplicating hardware (which would potenti=
ally negate the benefit of DUP metadata).
> >
> > One remark against DUP has been that both metadata copies would end up =
in the same erase block. However, I think that full erase block failures ar=
e in minority of the possible failure modes, at least from what I've seen o=
n the mailing list and at #btrfs. It is more common to have single block er=
rors, and for those we are protected with DUP metadata.
> >
> > Zygo made a very good in-depth explanation about several different fail=
ure modes in the Github issue.
> >
> > I would like voice my wish to change the defaults to DUP metadata on al=
l single devices and I hope that the developers now can find consensus to m=
ake this change.
>
> I'm totally into the idea of DUP as default meta.
>
> The idea that *some* SSD does dedupe internally shouldn't be a reason to
> prevent us from using DUP at all.
>
> The internal mechanism should not affect how we use the disks,
> especially we didn't even have a solid statistics on the percentage of
> SSDs doing that.

Also, if DUP is default, and both copies are corrupted, that will be
evidence of a double whammy against that SSD make/model: it's
corrupting data, and it's deduping. The dedup is in this case,
effectively, replicating corruption.


> And such exception is already causing damage in the wild, thus I see no
> real benefit from SINGLE metadata on SSD.

It'd be nice to quantify the write amplification of btrfs cow
(wandering trees) in the general case. The metadata is a teeny portion
of writes, but still useful to quantify how big of a hit it is to
double the metadata writes. It seems to be the only downside.


--=20
Chris Murphy
