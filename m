Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D676C098E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 05:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCTEI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 00:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCTEIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 00:08:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D837EF99
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679285333; x=1710821333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f0RzrlZk36B8QlnIxOLMByV1TWNDOIMn6+7Rb8kJGp8=;
  b=KsZlxUiwQDGjdkTmkrvrtHm2Ac0w4A4LNzQA44pooXLWcm9ARvBUBWqz
   68sfFVtLwouMNESIN1vNmngFHuGjk4olW/axnULgu/ijkt5sYoKiDoue1
   k/iTBy+2kNUDrE9i+470oodAE23l+OzMBSQY9Vcd0ElT+GLhKJdJwO1H0
   UD8x6Jw3iE5PZ9kyX4anOKzd9QbBbguJ5SCP20tPiczkFhyr5JsWmeRZm
   +OKMkJk/MkWWmnpu1uujUQdupU2K8ZPi2oq0w0ZYaVtOh7t0Om6d6LoGE
   +Da2A3nzIljvi5Ab0nLw7yiiRswIlj114UaQ8uIiridmxVrSGBtCYBQCn
   g==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="330416222"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 12:08:52 +0800
IronPort-SDR: 9YRGdgjeKXy5TjNJRA7bnjTt7/z4hhBgkq4FAmnrIn65a8aOF7sOq83NwmAlkS0lWtYSYjnVd2
 8BwAtqLVQ2E+mbVFsbBY1cT3j5SzCyBXE60Ehkc4uMuhA1O+NJrxuCSY6KI1R4/OuBb9IkqCJW
 0O4BEvKD/G9i3mcAV+xKbVk5a2eCGQ0VQY2HQEsTvNbYVvilDVHRgt7kUogd41GWZb1gNQUCfK
 s7FQII8gZrlLj7v68/atB5i6rSVkJebJbudPACxGz0GxEl0mBfzVu04o+kG9SkA7sDMLE7Eyvq
 mkY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 20:19:32 -0700
IronPort-SDR: 9xPk1wEfqZCgqhojSZp3/MP84+sREe4eQMy+LUH8TLfclmZtnjky1C5pNjj9a0CpD9DaHwrkvJ
 iQGRx4MoLrBi1/PlpbyzfrZBKE9mMT/vBVGUTMx/WfF5wAD/KwTOj9Gjen+wjXGTXMCfdHG0w9
 BwnWegD1ndhpa9LdPMGBl4QWVDYOXtebc7IguVVHomp8Y3AnQAJuIAPZAQtQQJDaWnOMY9+B/l
 Z3NpOS1/17kGVkri4gFXhjTIWe4ERm7Z5KkclSiXrL3zgYZMjjzNwO+DKKDbPdaKgVaWaRohm2
 KNg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 21:08:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg1Sg36FRz1RtW5
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 21:08:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679285330; x=1681877331; bh=f0RzrlZk36B8QlnIxOLMByV1TWNDOIMn6+7
        Rb8kJGp8=; b=I0Nr6eY4l+li8vQa4HU8m/tH6hxLJDU4QSlFmqc+lirqP6O+gEM
        v9s4ZT6POGQc8CFr4UrtpttXxqJaBsFgLQm2Wfg3KOIPlbKXox/hV/KnR/Irwr7t
        5kDR+T7lTE5z99Ka045OTKKJWeGudI0XeX3TlnNH5fBLfCeMpcKGbi25pDe37h9k
        51R2XT3L5fqAI3ACriH7E0kZt+R3YGmiMVoKjKntOPLOHvWdl7HsbbSQJh7AvaPq
        /IA02A8l4s7tqjwBBJGGoBBOANPekW7A9Yma+cnEzpJdlhkPe63oS+mfLcdadGWL
        PafSw2kf1WU73nLZ/MRaJQqGSih/w4kReLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pe5YC426OvND for <linux-btrfs@vger.kernel.org>;
        Sun, 19 Mar 2023 21:08:50 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg1SY32s6z1RtVm;
        Sun, 19 Mar 2023 21:08:45 -0700 (PDT)
Message-ID: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
Date:   Mon, 20 Mar 2023 13:08:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230320033436.71982-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230320033436.71982-1-frank.li@vivo.com>
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

On 3/20/23 12:34, Yangtao Li wrote:
> Hi all,
> 
> Out of consideration for minimizing disruption, I did not send the
> patchset to everyone. However, it seems that my consideration was
> unnecessary, so I CC'd everyone on the first patch. If you would
> like to see the entire patchset, you can access it at this address.
> 
> https://lore.kernel.org/lkml/20230319092641.41917-1-frank.li@vivo.com/

Hard to comment on patches with this. It is only 10 patches. So send everything
please.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research

