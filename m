Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525D631A8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKUHrF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 02:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKUHrD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 02:47:03 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130BDF33
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 23:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669016820; x=1700552820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0jdC8t1fAPJuSk5KJe4WNbrdRdQBd9MDnsplOb88a1A=;
  b=F/64PQOUG+5713oVq59TnhCuJem3HA4rRSDzu3/fkKIEE2a3YSuo799K
   5Y4S5YYY8HFFv8E5GlhmRCiAjEab/6Q/LSK7Imvnwl2/KEUAooV8rQBJZ
   ze0QPdpd0C9nIKO1eBbZ+x7bUFCJZ++ZJ4vLlUSGOePnCU+WrOsO5XiG/
   3HhpN7vXZLkEHzN3jlCHMwGDMl00uaFIMR7+loFyJbgg0fIQw0BkNGHM5
   lDKYN2m6lEz/4oZuaCh8ag+YdJoaMWdSyrnqsKgwyzitZAfwX2DEcHFKj
   CVkTDUwnK00MnEyud1ac+BOBBEN4y3gZf1p12m56VVdl4e8UiBmEykt4d
   w==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="328870478"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 15:47:00 +0800
IronPort-SDR: Y4EcaS/j0ZNqu142WDy5OGr55tcJgXKPenxey9tPfMcKLNLtj33MZABIUQQvSrhbvhD1VxlS6l
 KAX48sn+qlw+2VD6MM/P8wzeaZbnF11t7hhnIwroWk+N/D4SpGnk10NZJTpgl9Km2AYokxddjK
 ntFrp9JvGuKXCwRCzK1gFW03vOJoWQ04qPWqRrUbgtQjZ8TgHQyWqyKBQ1MD6ftjH0JMD3Fali
 C0pRg4nkWVhERepn/cgIbXJB05RruIYExPKQGtSn+YvPwX/fz86QJgMpYPQpp/YMgLUU5bNATK
 ykM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 23:00:05 -0800
IronPort-SDR: PbOFiReRkF+iQyJ2SpqukBACCnmJeYbAOiJ2hmGTclWhviJkNAcEhNgJt7b+vgLg7c0EwyAjT+
 jSydAnXMlCMw+2tsrw7yeNTAdDytdqON1m3cSfBNfplXWkKSTTIVjOhaU+WXrrookr7P1CtQ+b
 ihPtS+9K4OaCJQ/cOdsGB4TSws9ewy/oYrW2nKjlxjli748X6Ugdffj4ccJDP5a8L8hHSdnee3
 loGzTgy/QepGNoU0S3RwYugulkhN0bJonZXlA4Vlnxp/S6+XrUIGx2M/Frj8qMSyJgPWqVGHYj
 Gnc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 23:47:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFzxG5jc1z1Rwt8
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 23:46:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669016818; x=1671608819; bh=0jdC8t1fAPJuSk5KJe4WNbrdRdQBd9MDnsp
        lOb88a1A=; b=bQCgzoAYFYPM+M3HPgX0sr9tXBKSnQ0E4XSxFAYnldqJf4BVTAq
        N8dT4kKnq+++Ock3eeckRoAsUVFMUMp9w9AQqSy8kyhcXep/+X9QIauofHHp+01q
        13qmyGjDd20U+qQBZ4veo1FNatx0vrTyx5Rd2MzXICVsNfXvYV84TwLFgP+ocxfa
        6gDnIUxKpXaGpZ/4OU116Cifi3LRFLlXr8DWtTJj/QBnmj48f42EBtlKiVhZgHgf
        q6akI0UKRXY6RVSLTKoQMhBWP9YMrbRC+Gs8dBw05g9A+XlhdWJu1TBXK+6iZauy
        2HGJf/n6ZaOK7gNQaf4EWI19UyyS6qOkZNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gpPUm64Dqfqi for <linux-btrfs@vger.kernel.org>;
        Sun, 20 Nov 2022 23:46:58 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFzxF3gGRz1RvLy;
        Sun, 20 Nov 2022 23:46:57 -0800 (PST)
Message-ID: <893acfcf-59d6-07c2-0c21-1de124c8eafe@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 16:46:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: use kvcalloc in btrfs_get_dev_zone_info
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20221120124303.17918-1-hch@lst.de>
 <22167fd3-6a97-8cab-c6b8-a3415da89b3f@opensource.wdc.com>
 <20221121070518.GD23563@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221121070518.GD23563@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/21/22 16:05, Christoph Hellwig wrote:
> On Mon, Nov 21, 2022 at 11:31:01AM +0900, Damien Le Moal wrote:
>> Looks good.
>> This likely needs a fixes tag though.
> 
> git-blame seems to suggest the code has been like this since the
> addition of the zone code.  Which is a bit odd as I've not seen
> the issue before last week.

BTRFS_REPORT_NR_ZONES is 4096, so the allocation is for 256KiB (4096 x
64B). Not that small, but the mm code can likely handle that most of the
time. I guess we were all lucky until now :)

So maybe simply add:

Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")

No ?

-- 
Damien Le Moal
Western Digital Research

