Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F272C6C9A8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 06:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjC0Eci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 00:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0Ech (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 00:32:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0F4C1B
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 21:32:35 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1qPzEE01vI-010shV; Mon, 27
 Mar 2023 06:32:26 +0200
Message-ID: <a9efa03d-2472-db26-ebb0-dd6b21991863@gmx.com>
Date:   Mon, 27 Mar 2023 12:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1679826088.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1679826088.git.wqu@suse.com>
 <ZCERG/+o6515r06h@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCERG/+o6515r06h@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MuKPg6flB8QD7IjuqBYyPFPPykaZnnZ/dR7zkiTizZOl+wymPFU
 5X8TFKj9lI4sgGLWLOKxGS4yOKNWsdLpzuRGihBHDq+bnfaQOvgWskD5VUO68icxBuyGLsm
 YaEUTIz+5GiXtsxncPNOcFRZF6UCWmcJjHcwdpeh04HFXoqhXMkmA/uNY/USCOjkLMKnF00
 MR3J3fWXd0A87g7i3tNJA==
UI-OutboundReport: notjunk:1;M01:P0:btwUU/rNoOc=;LJ9DggMXDuMWMDOg8hRBPDan95P
 /RhlrhjZYKlBa4kM8CCq068LFx/J9LEP9PaG743djwbfWFgGGTbtR+69/7HiqL8TjXK5ZgZlt
 gkasNdOXiEkxWOOFPbE2YCaTIHeT97le+3TmrGIwDI4xGtN5t3/B8eHJ/10tvQpzupWiwv2iZ
 AK0xFUwDT5kpZkdUyFh2eD1XUVdcfM/fmE4sBylCSBQbc38KzJvVBqfRwFqYn6AW9ewcvnmUS
 ymhdaH6Q9n9W/p/XAE2NY3WVU6xVMZFwQN5HdsanmJaMWNiTYgdCU2I+GbnXoUQ7JqxMVsXLv
 WwD7sKcFDRmllmW0I68kM2Asigbpr7+d8ZeezlDwef6lnZlFiUSJsMIhpI2/oN3BywQ+AB81I
 xynOw/P/mosVpZI74n1oYmuIXujjg7v4LSPT1bI4WJmkeI10g0MCGXOFLub46GOJzVIc1kHVv
 jG1dR2cQdASlMvkz4iMSZFEDcp8KEKy8S+UxdrTc0cazEWkD/mkMba3ZdSnwcl4RP+daqUa1Y
 K8Ry9SL+Iv8TOnM/OKdw13/M+9wpGmKDXDivUxXuJEgxDH/KaUBU7lkPh0TmZfA1M1B5UmZJe
 TmqN/oAqsVvMoWrk9vkymVQUiim6z4CGdHWMtZsV+ad8NdDZeqIricCbwB53hCt5FTUaNcl6/
 /UFbqGyod2YieqSmixeH4YiJy56UIjSiOhD4ajZ2lM0xO1btDM5OMKMW8+APlf4z4nTLutTm7
 tVaZdtkG0xaPJ08Dt68lhYH7OtqFG90VoQSHHTvS2NN4SUMv/DnITIngJcBSH369xuaj7zdo8
 bOLwKs0G635N8y3AVYGhdxiI1yFneorQJhUmbPlI/z6w/7Kfg4tOZQfKD2eZrS0wbnBLC4bip
 PLQLNpybRlPo1Wr7icgiHqsNbXxzTopaLe8k5fbBgNIVUnxeL3D0Ig28dmu+fToXgxY9YoapY
 qFzoPEFqBeVR4Sl/Rq3y6doAeRA=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/27 11:44, Christoph Hellwig wrote:
> On Sun, Mar 26, 2023 at 07:06:33PM +0800, Qu Wenruo wrote:
>> +	/* Caller should ensure the @bbio doesn't cross stripe boundary. */
>> +	ASSERT(map_length >= length);
>> +	if (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE && btrfs_is_zoned(fs_info)) {
>> +		bbio->bio.bi_opf &= ~REQ_OP_WRITE;
>> +		bbio->bio.bi_opf |= REQ_OP_ZONE_APPEND;
>> +	}
> 
> Not crossing the stripe boundary is not enough, for zone append it
> also must not cross the zone append limit, which (at least in theory)
> can be arbitrarily small.

Do you mean that we can have some real zone append limit which is even 
smaller than 64K?

If so, then the write helper can be more complex than I thought...

Thanks,
Qu

> 
>> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>> +		int data_stripes = (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5) ?
>> +				    bioc->num_stripes - 1 : bioc->num_stripes - 2;
> 
> This calculation feels like it should be in a well document simple
> helper.
> 
>> +		smap.physical = bioc->stripes[i].physical +
>> +				((logical - bioc->full_stripe_logical) &
>> +				 BTRFS_STRIPE_LEN_MASK);
> 
> This calculation feels like another candidate for a self contained
> a well documented helper.
> 
> 
>> +		goto submit;
>> +	}
>> +	ASSERT(mirror_num <= bioc->num_stripes);
>> +	smap.dev = bioc->stripes[mirror_num - 1].dev;
>> +	smap.physical = bioc->stripes[mirror_num - 1].physical;
>> +submit:
> 
> Why no else instead of the goto here?  That would read a lot easier.
