Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5E680681
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 08:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjA3Hb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 02:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjA3Hb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 02:31:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389528D06
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 23:31:10 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1pNmL50e9z-0038KK; Mon, 30
 Jan 2023 08:31:04 +0100
Message-ID: <7215d466-7476-e322-e8cc-d5fd4841ce79@gmx.com>
Date:   Mon, 30 Jan 2023 15:31:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
 <e776fcff-3c57-1b77-9c83-bacc0e473f5c@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e776fcff-3c57-1b77-9c83-bacc0e473f5c@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2TUs/fBRhk1+LGtM8cjSwKsZEzPg1DxZd+XleoWhwRUQmGeMwYY
 B0e7XUoe2H0BAQKbUb5S/UtTMj7CKA3Waaw0A/0ypztkAf9n52etl6YM2x/OkuludtyTjc2
 okQpTt1vta+1ptfgoEBV7yxtxUIskGamwQ9PFBSCn8K7U6rmFDDwNUuOxL09bKI+tqwmmzb
 cPbdbgeRXFDK4c7hB/w9A==
UI-OutboundReport: notjunk:1;M01:P0:/WJPg0Guro4=;sWFjJzlPbm+x6B9yb1unFd8MNA3
 geR5V/i6uif29HX8sH7sBfVJurrH//jRLkeSed6m3ILKionR3MyY5ZnNrDE+WbVlixesww1Nu
 av6Evrnmh4QhmV9iPInNm9I1wwv+mlf6K9Q5w9uQab+lt13cyloJtfMBOI6mDzOhmNOyQkFpO
 Fgfi14/SeFHfGYx4F6WALhyCUH16UMhoWIN/PfkYk+2JPkeJ2Wbwn2axMXidpFjci9G71HOCl
 d6n+OSEFOauye04QA+tpO6UIjFRSwrXKOU/2EM8mhrfr9ICfIfJL2XDdiC6v9hAu0G4Lrr/Dz
 sZ+kWcvAzpDuE3OI3yfpfnOO46ocAggE232cqqD7BwNwzpHolnAYAalTtBiES5cbTX6aG2SEt
 nfdPQR+9w9NeJaShupCOHhLOe52lbPkc3K8R29nxYNn01WdbnLO7Jqp/cdE9jsz11h1gEfDgw
 kkPmP5od5PBlA/H2ce0RYx/d+Jb2788tcksdK+PfkaAYr6nsdBrd22Qrvja44VePaDHsAVzZj
 itkS08GcEQm8MVNprz2kt36zvcguy16odYM4a/v+w+p669ks3pmqX1bS3Aadul8gdGfBWpGlh
 Ri7QFCRN0RTJwWmd6seK7xK+dAPWe6IkdN6TGF9EmV8WKKudSnxh1dKGioskDn0GU/ITjRdfu
 JevdZeytHmrEFOQY+gRvd20CndySSZ7PlGXzTxWwi0lca/crnAHv2+m30bgMs+YOxBWtR+7iX
 85nE/NrMaXJozIUltMiDMgFwmk4SyTHrHcESe5i+ipTRb1XVl2OxnRQ8p4XDj3g76r+WhlA28
 eCICUlEGHX3uR7XRmUz+rg77SmMfwRc9v4epTsRT9CxlvcMwHMWebOz/t8xE9P8/yEr6GyBL/
 vLiP5m0xNYH+dqmO2n+RTIMaNFpEpguZ62+1JVBFxZx/p/0wcsO9U7nuuAUcxrpBYHwGPLpeO
 IKqAkIL2qwerD132ugANsltHlv4=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/30 15:27, Johannes Thumshirn wrote:
> On 28.01.23 09:23, Qu Wenruo wrote:
>> @@ -5888,13 +5888,22 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>>   						       int total_stripes,
>>   						       int real_stripes)
>>   {
>> -	struct btrfs_io_context *bioc = kzalloc(
>> +	struct btrfs_io_context *bioc;
>> +
>> +	/*
>> +	 * We should have valid number of stripes, larger than U16_MAX(65535)
>> +	 * indicates something totally wrong, as our on-disk format is only
>> +	 * at u16.
>> +	 */
>> +	ASSERT(total_stripes < U16_MAX && total_stripes > 0);
> 
> Shouldn't we better change 'int total_stripes' and 'int real_stripes' to u16?
> That'll imply above ASSERT()

Right, that is way better.

Thanks,
Qu
