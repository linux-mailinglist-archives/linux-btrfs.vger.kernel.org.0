Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FD418D05
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhIZXPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Sep 2021 19:15:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53435 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhIZXPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Sep 2021 19:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632698005; x=1664234005;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=7WaRSB5N6SoiJ6Yfu3NMHtZFgT5ckxKWpwAFggq60fo=;
  b=jdKT1mu0lZjsvK18ynM6mT5b8wsHBZEgx387jlxYaNX4wQMzM/aZ6h6l
   /ElOCtwlVU4bij3ggTnhorFpxu7rWNOWecUM1D1DXtkunmj2hNWsa1kbr
   nVwJz/8cwSH7yv2IYMCTinQNRlu2Qe8wkwO9f+cacbf5ud3CI2jjGyao7
   idJuQqC0+jN4rYF0SMlh2//nr6OQ2ldn4Q3f/IDYJZErtck9VEgooagj3
   zBMDzRNWH2xCY7Jj3rySVdjd5SfL0CVykGb4B0YpUFQXIn+7+dpD6npHI
   R/WzNko3lGGJhGmclRHd52R84W3VHUwc+rDvX0Lrmub/gnMvaqNsvNMEB
   g==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="292650084"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 07:13:25 +0800
IronPort-SDR: Y7rwjlqEKQKfLn50N1uXtzBfapBC7DrT6u88jj0uo9mM3ONMETPxxNQZSbaiwqTUVy1+Qfxq3A
 0P5s9dKffij/CodGkAhmrIMYluLXh59LX7J5BVHSPH04IDdtGvLQPrH8DLDnlFajOiojHwGo5q
 8jcS11t0qXv6r2TNqVxmlDG4BldbhOyUTDiQVO1Ylzzn1keZgEADbnNo2kgNvrpyBLt5F+1sZG
 R4LuVv0/Ron52TL7npaLoZ9LnB4cUHkUhjZmmXwormWPjEFlhv6dHm/LBl1lUlEwPX5Kw8suCF
 TtOf+bM1XVkiy+WfzOmRUT22
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 15:47:59 -0700
IronPort-SDR: 0zjNJGmsNoQkyS5QXi1+9ZGUifWvnx5TaDDBOMxxFuptq428LDWZLQNeRKIs6gOJHvS0Sa4Slh
 L7jG7PPo7g1vOeXTPHkgvX6+GL9qRPDirl4O4MaiAqn9QAnhHvZShIkgQadjvlizFN3DCz4bSq
 4WFCtWU/6Db4//jLPMVpBzCrT4t+yzDpnAtNv0ZzfvEO4MNgGX7KT+LL3dGllx6dd1aXAFOHYG
 CLsFApYdtpAqegWBmTAqE8wQlegsxeZDfjMxGDF75SPNAUJkITYhhiWs3UQKrc9gAH5KrGhD85
 Ljw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 16:13:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHhQX6Tc3z1SHvx
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 16:13:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632698004; x=1635290005; bh=7WaRSB5N6SoiJ6Yfu3NMHtZFgT5ckxKWpwA
        Fggq60fo=; b=pv07haGZhg3PJAumyvXPA+iKkn1E0yVCBH0Wqm6RRWkaZ9uQgzx
        jHbSqL473HRT6mUXi8fuWn1xeSUHMmrMc7/ZmCzBGUShd0WYTV8HTmq6qmoOLVcO
        hPOT46R0XhZFDJQKbWQElzJsk5nNC9JAz1n4xnJDK5C63ufIs+7Y/NmCQQeaKnBp
        iaHvmz/v4vB+dBdo38T3HAqWvzb7UJQadScTnPNYYMWF4uqJGfdxpXS9hdtTk4Pq
        dA0wa2NmDGqg42szvrChyCuPYz3fNUmX4z0QO/lyRBjI3z3T2YrVuFOhNmBqFwtM
        uodnCa41bQhl1KrumSoK+TS5x5SEFlT+niQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j8lsgkXqQQrB for <linux-btrfs@vger.kernel.org>;
        Sun, 26 Sep 2021 16:13:24 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHhQW5fLRz1RvTg;
        Sun, 26 Sep 2021 16:13:23 -0700 (PDT)
Message-ID: <b57cace4-fc85-2a5f-e88b-d056b12a2a0b@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 08:13:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: seagate hm-smr issue
Content-Language: en-US
To:     Jingyun He <jingyun.ho@gmail.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/09/26 22:57, Jingyun He wrote:
> Hello,
> Btrfs works very well on WD/HGST disks, we got some Seagate HM-SMR
> disks recently,  model number is ST14000NM0428,
> mkfs.btrfs works fine, and I can mount it, and push data into disk.
> once we used up the capacity, and umount it. then we are unable to
> re-mount it again.
> The mount process will never end, the process just hangs there.
> 
> Anybody can help me with this?

+Naohiro and Johannes

This is not a hang. Mount will just take a looooong time due to an inefficiency
in how block groups are checked: a single zone report zone command is issued per
block group, so with a disk almost full, that takes a long time (75000+zones
checked one by one). Naohiro is working on a fix for this.

> 
> Thanks.
> 


-- 
Damien Le Moal
Western Digital Research
