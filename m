Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBC1B8CCA
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 07:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZF6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgDZF6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 01:58:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2FC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 22:58:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t11so11070519lfe.4
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 22:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRHYKk0cAK9iQ8dbO2z8hGkWBxVoF30VDpbLNYJldK8=;
        b=A+xOWq7pf7BTm9yQe+3pt3xNHtXzzmME300uQmVeoNzqhbdBvIGcQ0tgsXReOglIcd
         wIRSFcrhz3C1bqLK32CF9SpVJ610i0++O4BnFzlV3PMSHxtLxf8r4/qQSxwK1QMtU2gT
         4nr5IlUJ2PkxBmcN59NgtlgW5amlsQCUeWW5P55YZnETGHm9LJuG1wiOAvcl5i8JPzny
         O+TBEf4s4BrE22155skTynG9HADMlHccQjjxZBwCTCpUmja2cNfbzoe67VLxcB0ZLVpX
         Vrd8zfXG1ieW3FV8hCSzlGT+1QDnJksmq8/B1koktndgUo9/D1U+AreWNTRCHYDyYmPH
         XL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRHYKk0cAK9iQ8dbO2z8hGkWBxVoF30VDpbLNYJldK8=;
        b=mOL1JRcvKEDjsq/br5kpNtiBSSPhtkmMUpIWotBPcB+VaBICcFy+IV2pkLvj4Wmc07
         ZCLRANHCd44VYm1SAfwvb1t1Jg7hl9nt9ExSNQsdh02xf3hjUYCNA0pfDRIJkbXO4o7O
         glNS5G3qsWSBesyEL+UsyhYn2G6UFqCDN6zSp7zRDqKysj7Hk/TB7pOiqk6xAhyyN0+c
         OOAOtJySHzRIS4PeWisG4JLfmEwYOA5iqDHCQKS6Ty7gkzBainMEn0ZM2wUe1Kj+Mp9T
         4uYxYCWyitF3g9FrMMgdlMYqN5AVislpFxoqVetOttT29EGD2hEN/fUWPjxmelQK52tz
         6vHg==
X-Gm-Message-State: AGi0PubZsM/cV6+S+uin99YJQ0pN/zMLdnlA5u6DgmS9kCSMiBIMBjZt
        cTmD/jMvBwfABpPElaZgf64wEItQ
X-Google-Smtp-Source: APiQypJMoAz1IZuygCoY2Zu/faCwM0xFXaS9xdcDyhFQ1DHxIyMC+nkO9G91l92cVWEBAvyBIECWDQ==
X-Received: by 2002:a19:e041:: with SMTP id g1mr11356472lfj.70.1587880721388;
        Sat, 25 Apr 2020 22:58:41 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:48ee:3630:6817:757e:9dcf? ([2a00:1370:812d:48ee:3630:6817:757e:9dcf])
        by smtp.gmail.com with ESMTPSA id d23sm8198660ljg.90.2020.04.25.22.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 22:58:40 -0700 (PDT)
Subject: Re: Help needed to recover from partition resize/move
To:     Chris Murphy <lists@colorremedies.com>,
        Yegor Yegorov <gochkin@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
 <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
 <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com>
 <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <88488595-8392-c6e2-2784-84607c233d84@gmail.com>
Date:   Sun, 26 Apr 2020 08:58:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

26.04.2020 03:56, Chris Murphy пишет:
> On Sat, Apr 25, 2020 at 3:55 PM Yegor Yegorov <gochkin@gmail.com> wrote:
>>
>> /dev/nvme0n1p3    309248  368949247 368640000 175.8G Linux filesystem
> 
>> total_bytes             188743680000
> 
> OK, actually I'm wrong. 188743680000/512=368640000 sectors, which
> matches the GPT partition. So I'm not sure what happened.
> 

The original error message (bad tree block start, want 1048576 have 
6267530653245814412) means content of root node is wrong. 1048576 is 
where btrfs "starts". If you cannot read that, you do not have any way 
to reach other data. Likely something went wrong copying data.

>> ERROR: superblock bytenr 274877906944 is larger than device size 188743680000
> 
> I don't see this value in the superblock.
> 

This is the third superblock. "dump-super -a" may show it.

> What do you get for
> 
> btrfs insp dump-s -f /dev/nvme0n1p3
> btfs insp dump-t -d /dev/nvme0n1p3
> 
> 
