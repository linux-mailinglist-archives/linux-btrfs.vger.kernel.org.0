Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5D418D37
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhI0AJJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Sep 2021 20:09:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8910 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhI0AJI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Sep 2021 20:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632701251; x=1664237251;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LcCnIp41FYpUPbutH10Qgz5gB9rJfLeCeigCM6UuucU=;
  b=KtBnLHNCerc7oJ6ecueIPa7jsbjQjnU5xuBXgKSI4P59DWyuGeJMs3mS
   2q/0p6T0hUn4C8iBX0fm2RcMfT9Xfj/Vi2i+VWZ4fRjRFMWiLuPEuuFUo
   WaB1Xl9Qkv9gnlxs45QXvRf6zk+P9y7oev2C/0YlapChSZy7nrlW6F8Rj
   HMk2bfVPNmgOI0RTaJX+a3mGopy652GCfWQDRkdmPWzsPmT/a7OqjE9xj
   QtuKiv1VzozSYV/FvRKAHFdKqhgf4849PzuIp/u/y/POhLg9xyt2Phe/8
   Fj3i8+KI3ij90XCMbX1X1dca1hG8hQDbV1zRC12onwt3GOM5q0zbzkmrt
   w==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="284810885"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 08:07:31 +0800
IronPort-SDR: Q5f1kvDqmLvZTsUuG1jyZPiz+BjkJCUaJez0kFf5OI3CSWwk8R5EyFzeS21AaIvyLt53bA3O6R
 T0lewnbcdGW2r5ZmbRqNGc1NWnmm6w4M97WDALeNu2rI4j8+JuXEz5TZAx7w/pzZZj/ox6u6V1
 sVIrza0KqVRrWFlgJV7WQVGMTNMxmzoIfPptYEJP+SVWx+BJEhUfm2/isK7WozTcFVDnvkNJn4
 eUsIifVWuf0A/BBcLKgnbvXpQy9W6kV1P//wNJjRRmv0BCAfrHqGRG1/Lb34D1ZGQNkWkVANF9
 W89EcJqzlYNSvV7jmYc17Ltn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 16:42:05 -0700
IronPort-SDR: BbVbiS4SlMcXSXE3rrCWCGIkbXox8uLis0yWZPBO1+wIJmWitpYgqUksGTvfcJLqlGZINUjTJd
 LFwlOFk+eSugpK77dgrAB00ciXGZoUHY5YOjYQNDr/ZWXSUX56dChGth7gQ/jk4h5JuD9CyQu9
 6dxoqnMxr7+S3iBUlKS6w4OC535LdFU7jevJTWjeqcAQsvDNn+K2gKByCZcMCbM+CQNAsBAcI5
 5fIyMATLdLFIRsXtAsk7jUCXVa6SCW59Glg/NZbpBDm/2azzlcux9Ok4yoXeon4yjjD668azR1
 +j8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 17:07:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHjcz2Fd5z1Rvlf
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Sep 2021 17:07:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632701250; x=1635293251; bh=LcCnIp41FYpUPbutH10Qgz5gB9rJfLeCeig
        CM6UuucU=; b=Cqyqtr9A1M3e25QupM0VDtlkdMrMvkBIb8mVrWuq6sjLms9wuIg
        kwYSp9mnDy/PIMOTqVX9rRxAyqvSu8ketk8uAl3YkGk3k7/TnoA3nD3JOaypbZq0
        QEz80ZASraLlph5G9tiLUYA2tRR5Jn/5XdR8a/apfDSbVZutwjU9m8FZVU6p6la4
        z4v3glaJ6r3ZLhu5ATN7y343c3oQSm2ehQH+c6nc0TgmYRN98/5pte60AD5zHhqi
        Lkf6lEt86c3rdJg+iSrCecdxtstDGpTPWXNBlDlRTy0Jl1fZVCmoqHmTEhZOC2at
        a7Ci/L+Z9M4YJlhgc9m4vrT/P00OJPKjYAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vg2VuBErGcHW for <linux-btrfs@vger.kernel.org>;
        Sun, 26 Sep 2021 17:07:30 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHjcy22Rlz1RvTg;
        Sun, 26 Sep 2021 17:07:30 -0700 (PDT)
Message-ID: <54911068-8a81-4201-bf1f-e8dcd196bb08@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 09:07:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: seagate hm-smr issue
Content-Language: en-US
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com>
 <b57cace4-fc85-2a5f-e88b-d056b12a2a0b@opensource.wdc.com>
 <CAHQ7scWo2hF1r0k5_NG2kfAuy0yMxjrym866cGpxRf2Oc2cbMA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAHQ7scWo2hF1r0k5_NG2kfAuy0yMxjrym866cGpxRf2Oc2cbMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/09/27 8:42, Jingyun He wrote:
> Hi,
> You are correct, for a WD/HGST HM-SMR disk, it takes about 15 mins to
> mount a full disk.
> 
> But It takes about 2-3 hours for mounting a Seagate HM-SMR disk.
> 
> Have no idea why Seagate takes so loooooong time.

This is most likely due to a difference in the execution time of report zones
commands.

In any case, this will be resolved soon as we can cache a full disk zone report
during the mount operation to avoid this slow per-zone report operation.

> 
> On Mon, Sep 27, 2021 at 7:13 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2021/09/26 22:57, Jingyun He wrote:
>>> Hello,
>>> Btrfs works very well on WD/HGST disks, we got some Seagate HM-SMR
>>> disks recently,  model number is ST14000NM0428,
>>> mkfs.btrfs works fine, and I can mount it, and push data into disk.
>>> once we used up the capacity, and umount it. then we are unable to
>>> re-mount it again.
>>> The mount process will never end, the process just hangs there.
>>>
>>> Anybody can help me with this?
>>
>> +Naohiro and Johannes
>>
>> This is not a hang. Mount will just take a looooong time due to an inefficiency
>> in how block groups are checked: a single zone report zone command is issued per
>> block group, so with a disk almost full, that takes a long time (75000+zones
>> checked one by one). Naohiro is working on a fix for this.
>>
>>>
>>> Thanks.
>>>
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
