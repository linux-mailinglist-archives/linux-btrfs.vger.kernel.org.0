Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8964CEEFE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 01:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiCGAna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 19:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCGAn2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 19:43:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6F106
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 16:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646613755; x=1678149755;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pzWCGpzehAXfzhqpe7MjwET5WOtGNDQmFo3lPrM4zak=;
  b=PPiMprZ9aJUCiKtHJfWuyj0ILl+Yqd4IbfhWYgKsnZij+kbhTyyqpwRp
   L6ENpM6/cAChXBHFYAmphOh9CnJV9rHFyAucjD4UvLh8SM9xEfm01cwEz
   O6n/XTYO83E2ApwzGbLZtuEzcST/JyO8CCtoME4qsHz9ViRppD34H6yW0
   dgyXtn5o/dSt0hBi73SYRNIjtMb/iKQ2vqVcG3nn6pueS+Pj+2whWKbzm
   G8JtIxW86/EeznVgVHMZ6+MkvLvlUmKqByabWQYaM8lpz/wxotBNmZXon
   o6fZLRvQRJlPhks6Ai3XdijgnmWJp7XZakwYM99/v1T50iNbFFN6WztsV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="195575130"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 08:42:34 +0800
IronPort-SDR: nydjTV3X7cuQo9rOdHjaUCFHIwBTdySn0jQ9d6tIAHWjqHYtsKj7qCnIk3W1/LZoRaKfZ6WtEz
 wTltOocfKo4zI8mJ194WmYpM3+SZARYy3A7HaK0MSo0KZ9q4LuYjmqFrMKnQNjFMzNGnEm8vHa
 l6JLwlvLNhJIlcpcTQsv382bhReBczYVGhSNZqUb1tKpFuK/zFZviUfjhRiX6vracnDvHTUxxR
 B7zp6OKxFgrvYkJNd0jpCM6x0jtFmOP0aqIPfaVja1CnKBGUl3uXCV86IG4wxuBfdpHwTjz96f
 QmGrA6MI2Mw1U1GTc4veexXG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:13:51 -0800
IronPort-SDR: j5R6bPb0z1wpO2/276GW/joPt2Op33i/bgRn/ijghVx7LNkwnLMhV00z76zV9PBuf59HD6D8s4
 4hxJRiInX6AlfGmS0UI4lSkU4dO+HKAnsCQ6VJIV6zNCHQcW+vs5NEbBDXO/e06jSP5EONnzg0
 /+xVskDeR5rMtxU/Tk+B9mtxT6Ia9FJAKIXFBp+5IyDgkD3lnb5mD3J8txXAZz9FL8OKbzkC4W
 iX7XDMHEiPzyvE1jjzRlQdfewEhvCwV144/NhC/QtwOGHQnM8995Q+6VLz3STv+0veL9WSE58+
 ypo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:42:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBfn50JNQz1SHwl
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 16:42:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646613752; x=1649205753; bh=pzWCGpzehAXfzhqpe7MjwET5WOtGNDQmFo3
        lPrM4zak=; b=ZofAJ/FY5K1S383CzxENjeEBAmwhK46RckH4ZT/MURa3ihjQEfc
        oMk6XQPjvMw887/BgubANN9m6HsIwQmMQpp0bV1Zm31yMTkjgucIEK9+eHKxO7VZ
        qpsztF2vvIiZdYjXJZjCIRhkc6yoF+sb1BPuWJGvZKgsYwg2ILs5BRKr8JzgtHQG
        QR6GfDuI59bYhzTt52zPUlScxSGcDDT4uivG+LjVovJUkgc6+XuuXDEx+PAwOLvb
        CqWPKn+5xswe0MUUoEH1qHUEMxCRQ34wz1TbV8pf7fIUuxqOLTx7F9b5NkmoX5ak
        eq9qKE486K8JDXGuZFdNDTMQcaB1aSeAx6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EvOIDEXD_ZfU for <linux-btrfs@vger.kernel.org>;
        Sun,  6 Mar 2022 16:42:32 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBfn40fJlz1Rvlx;
        Sun,  6 Mar 2022 16:42:31 -0800 (PST)
Message-ID: <c3b39f81-f5e4-ff06-b1c0-98501d77d79a@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 09:42:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Content-Language: en-US
To:     Jan Kanis <jan.code@jankanis.nl>, linux-btrfs@vger.kernel.org
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/5/22 08:33, Jan Kanis wrote:
> Hi,
> 
> I have a btrfs filesystem with two disks in raid 1. Each btrfs device
> sits on top of a LUKS encrypted volume, which consists of a raw drive
> partition on a SMR hard disk, though I don't think that's relevant.

Hu... SMR disks do not support partitions... And last time I checked,
cryptsetup did not support LUKS formating of SMR drives (dm-crypt does
support SMR, that is not the issue). Care to better explain your setup ?

> 
> One of the drives failed, the sata link appears to have died, if I'm
> interpreting the system logs right. As it's a raid 1 the system kept
> running and I didn't notice the dead drive until some time later,
> during which I kept using the filesystem.
> Something wasn't behaving right, so I decided to reboot. After the
> reboot the btrfs filesystem didn't come up and one of the drives was
> dead. I was able to mount from the remaining device with
> degraded/read-only, all data seemed to be there.
> I took out the dead drive and put it into another system for
> examination. After some fiddling the drive came up again, so it wasn't
> permanently dead after all. I was able to mount it degraded/read-only.
> It looked good except for missing the latest changes I made to some
> files I was working with, so it was a bit out of date. A btrfs scrub
> showed no corruptions.
> I put the drive back in the original system, thinking that btrfs would
> either refuse to mount it or fix it from the other copy. The
> filesystem automatically mounted rw without a 'degraded' option, and
> the filesystem could be used again. The logs showed some "parent
> transid verify failed" errors, which I assumed would be corrected from
> the other copy. Attempting to mount only the drive that had failed
> with degraded/read-only now no longer worked.
> 
> It's now some days later, the filesystem is still working, but I'm
> also still getting "parent transid verify failed" errors in the logs,
> and "read error corrected". So by now I'm thinking that btrfs
> apparently does not fix this error by itself. What's happening here,
> and why isn't btrfs fixing it, it has two copies of everything?
> What's the best way to fix it manually? Rebalance the data? scrub it?
> delete, wipe and re-add the device that failed so the mirror can be
> rebuilt?
> 
> best,
> Jan


-- 
Damien Le Moal
Western Digital Research
