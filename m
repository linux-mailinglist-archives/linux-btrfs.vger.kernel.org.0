Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC38B54EBC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 23:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbiFPVAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378315AbiFPU75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 16:59:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC860062
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 13:59:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GKPXFW002319;
        Thu, 16 Jun 2022 13:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=edjIVyRE+X0xy9z/DpJMqtXKVXBZjZkddOS5ryxopOA=;
 b=dYggglU5DWLBxClFUjusn+jEAvMBFLmzfOEdRO+cpodtMOYQGHQXIkPJwRSPY9gVGBha
 dvEdn5y65nQ+FRheZL03FFjFbg/yBsOOyG5hjNBubIOCtDnaIH5/nKnpXyFJa5y+Uis3
 3KxrnMhI2TwkYKV9aMUQ5ecvvECKfCD2I2w= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gp8ax3fqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 13:59:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1TyFTqDriFJ7EiStUpVS4GwcrL53nsncNVTWLFMywNZ/MKqbb5vwI3+XbHstkPOQrMFn9RDASEOOZPtSDOpiKEHUW3OI4KzV1BqfIWXpwuDR1MzdUY1zqsq3fLlOWy3aYEgNahQ9AMb7SKv+w0mbaQPMpbE3dfhdR96XX/GNowhYT8ll1BhGbKSX9iLPxgjiI1zUorV5+jjU3idMtJ5sfYWiGK3k8oIzVOfFLuisVmYSZIjZf8lqP97iSXaYF7CAv8xAAAPRioJNrmTPwmfIXDjV9ve6ZoUj4UodDvR9AZgwYqHlCYmSIekZhKoYzGn7QlKTZN5YWQkExHvwrYW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edjIVyRE+X0xy9z/DpJMqtXKVXBZjZkddOS5ryxopOA=;
 b=H8cZoYq283yZCzRVsGByzIZ8tEPrRKDFTYAnHPXFHwUFzVzhzfkDmOqXHotdg8wrxTK921zDJ3KTc+V6Inh3n6ZtH45NkfM3fbbNTF+iOY1VMy8NAyIc+6R22aZw+Z4xJRqIUooJRtbA7gLG2p/3jahx7SNjxQDtMp3xKzSs88xy5SJiuNN4EgIH6OIWzzrb/x+EaLbVQIk9EdHif1Hd6IquZ0gW3z0KvsD9lyTdCFF4u0cDDAniLJPdyqVUGXDs81khkCrUNnNp61klIHvcH0tiUhwRJt7GZ4uLFQtSglF3bAT6+A/rVL432gC1UsQylpQvhpycnWBmdEyJWem37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MWHPR15MB1791.namprd15.prod.outlook.com (2603:10b6:301:4e::20)
 by CH2PR15MB3718.namprd15.prod.outlook.com (2603:10b6:610:c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 16 Jun
 2022 20:59:50 +0000
Received: from MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::e17e:e90d:7675:24b8]) by MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::e17e:e90d:7675:24b8%11]) with mapi id 15.20.5353.015; Thu, 16 Jun
 2022 20:59:50 +0000
Message-ID: <3b9bd6b6-ac63-6f8f-85a0-30ddd86f47d8@fb.com>
Date:   Thu, 16 Jun 2022 13:59:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v1 3/3] btrfs: add force_chunk_alloc sysfs entry to force
 allocation
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>, boris@bur.io
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-4-shr@fb.com> <20220404170221.GU15609@twin.jikos.cz>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20220404170221.GU15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To MWHPR15MB1791.namprd15.prod.outlook.com (2603:10b6:301:4e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9785f38-3912-4966-a3f2-08da4fdb2742
X-MS-TrafficTypeDiagnostic: CH2PR15MB3718:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB37188B6F678AF529525E4764D8AC9@CH2PR15MB3718.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWTtFHDrbQcRl9fu7dIx4v+m5953OetR4VcMCKftAE43jlYi3zlzMAxTNYLKq2aRIZuLdTAXGmrBLHoGLHGU+1hNHnBOXxTcIydMSOSDoOU4G3T15H8JWXhf2sIXkUYYhjEmAO6mQ1ejcjgL4r+Zj4gxJ6JLidDQxvKOh/Cfye74YFtmtol5jx18Lt/31FdjAOBLUclhDYUNm3q+nmdma0nioJbMRNV5XUskPnaYMEs0yPjx+uCjJED5OwOlSF0r4XFaw9v0FEx2iAnkoMuaVxa11IygO8T2l0KflI3j9ljiJ6a8YTVFHPijcafbfw9nuyKTmTm2dHWj3lpq7zduSljieSxEd08pK7ujvvnIZqWR3vIBDisCLuuKOOV62E8zCmdcupci3mxte3Hc6bHKZl1CFItRs51VBkjEga1mPwb5YMqocVcTNSnfAchrw3yqN+pr5L7xlIxUZUhwe0+luxOBYWzHwVS6tDAyeh186ZgWKK3UMG9K/wcPN5be9RfUA7N2SrfYnuZzpJM27rydLHC6pDJyeVTJKYswY9z7fqhVRsdvfmcVuJAsj+O+dYsBIB6h00cFpgF8KZ95IcIX5pKhuoSWeFUhv8BgK/N1lWWfBSOpaLV1C4qaUMcKNM40gulNOohrwfsT8CMo4Pfn88odx7OrQoP9Oa0FuLxtPHDtm730dh45rAtAMU18V6NpyisRQUHSS7XVYNvRbND3HZJMlLk1ALAt/H3FLS+IlpJERLfP0NeAxd/J+IrN7hVP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR15MB1791.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(508600001)(6486002)(8936002)(5660300002)(6512007)(186003)(83380400001)(2616005)(2906002)(6666004)(86362001)(53546011)(6506007)(31696002)(66946007)(66556008)(66476007)(8676002)(316002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWFLM0dTSDhncE5xTTliQVNjMmtPanhoM25HM0dHWVNxdEUwMzdzK3Btd0Z3?=
 =?utf-8?B?MkRsWVBjRmFJRmczRVlISllWajZmRTVCT1lqc1F0c3JkUTNkSkRGcUxqWlF5?=
 =?utf-8?B?NkptODN6b3A2cHRjNE9xYkp5ekhSbURJekxBbnBWanNhQ2FtbEZncGRodWJx?=
 =?utf-8?B?ZTZTbHZnYnFnWmtucGNlako5VW51Q3BZUm5hdkh2Rmh6VkMyTnNHTHd6VHYy?=
 =?utf-8?B?a1RMMWZvc3NTT1FxZmxNQlB6MEhaNFprREpzSWY1SnUrdTdUU0xndEhEZGxi?=
 =?utf-8?B?RE1xL1FHNXlHc0JFd0FremhFVExtS0ZUbDlJMFZSRUJoa2p6dTVONUIzWnIz?=
 =?utf-8?B?bTRmVG56M200ZXUrQXJ1YUUwU2RDQzk4aXBtR29PUGpCaG9VREFwRFQ1V2Nz?=
 =?utf-8?B?SlpwcTVCOFlZQWN3Y0xCRzljUk9ncENFTEJ4VDJTWEhPTGR4WXJOcDZYS1c0?=
 =?utf-8?B?LzR3L0poajJjYVUxaUZHN1phK3FHUG5jaGxKdmZuTVhYemdFdEszWVM3bGxq?=
 =?utf-8?B?VTEvdTFia1dDdlVwNVA4ZG8raVMwU2ZxbEw5K0R3RHpxSm5ualp5MkV5Rnh0?=
 =?utf-8?B?ZHhzSjBod3dBOEVjdXB2dkE4bEUrclh2NFdYZ1hrdlRjMHllZzVUSFp1SGxy?=
 =?utf-8?B?S0Q4OXo5eGdoaXhramhpcVF1RVQxM3l3Z05HSXdTcUZsWmw4V1JzUnk1dFVy?=
 =?utf-8?B?N3NWWmdTM2xDclN5bTMwZVcxcWhjNlJxeU1CMFRLaC9EbWtzZ29SWGFpQUky?=
 =?utf-8?B?Z3N1S2I3RDk5b09rU1RQc0M2cTc5V2d1Q3lGbUF2MFpicDl3d1ZPMC9HMDBS?=
 =?utf-8?B?Y0N1cXRSWGd0ajRoc21GVlkzMFRMUTVpb2lyWFlDSGQ4NmVBUWJScit0SGtQ?=
 =?utf-8?B?bm8vVFdsOG1ONFVlZXNjQ2ZoZGpPVFNBM1pHOHJjWXdFOWlqYTFUdG9Md2lW?=
 =?utf-8?B?Q1ZrekIxdGgveDA2SUpwTE9EdUFrOTdKNVV0VTVvVzZYdjBoOXpEUDg1TnY0?=
 =?utf-8?B?blpqWUZVUW1pOEEzeTRMOVgxUy9rOGU1WGFzbGI0cnpoK0psUDc0RW5XV2Ur?=
 =?utf-8?B?MjZXRDcvK3dmUUR4SVI5b0VyL3VyVDFoMmY2YjFGalhYMCsrN3BjT0d1ZXE2?=
 =?utf-8?B?YjVUVDRZeWxCTVpDdzVxdThtaGZ1SW5GNTdZbXZmTG5sWEN4RkhqS1RwcWh5?=
 =?utf-8?B?SXg0ZGpwdEFJTTdoVWRYTmRqZnJmVjhFN1IwMXlXODhaMDE3c3FzVURmU2FO?=
 =?utf-8?B?OVNFOHlldTlReHdCaHV3SkRKc3R3ZW44ZVRCdnEyNkg1QjJqKzdTdnFqdjBN?=
 =?utf-8?B?eEtKRUlTcWp5Mmw0THkvb2VpY0sxWk1qSzVHU2dVS3JIRzkraVFYaytUcHZ5?=
 =?utf-8?B?c0g3bmdwdTRFZC9ZTklIUjFVRkEwcFh5WUsrc0hvczVYK1RoaURCMUlRS1pl?=
 =?utf-8?B?QW5URkR3Uno3SDBXZkNPNGdPTC83WEtidVZaWWNyYmpzWnRQdzhUM3dubzRt?=
 =?utf-8?B?U1RPWnBaWVQrUlEydTJYY0NEM0l5YVZ6aTVDamJCckN4ejNiZ0dQYllFNWJl?=
 =?utf-8?B?Q2lkcVBCSS9OMmNUY2R2Y2t2K08rYTVSNnY1dW9iMm9NMWZNd25tWWhnbUpl?=
 =?utf-8?B?dVBIQU1FekxEaHBjeDkxK252RGJHOWhweS9RY1cybTBwQzc3djRGc1haNU1o?=
 =?utf-8?B?NVdVcURQQVFXcFloVVZpdWdEcU9vd2ZnMnRsUTl0U0FYYkNFanVDTlk2dFpR?=
 =?utf-8?B?NnY0a00xTEpEWFVCQ2crK25MNktwcE10ZXFteDlJWVpXTmZLMklOT2tZT2lw?=
 =?utf-8?B?bVQybVhDNk9FSnRWd3lLQ2t6eDhPUTN5alpEQjZsazNSQ3N5RnI0TEVKbVlQ?=
 =?utf-8?B?UHltcS8vSnZIVGpJdXBkWjdXYUgwcVZOSUMwZm83VFlFUkRXakJldEcrVUk3?=
 =?utf-8?B?VmFYZi90SFFCblgwTXhuNEdTS0wyZjc2RVBTMmo1blJyZWdFREJGcFptTVE0?=
 =?utf-8?B?RVQ2aDF6V3dydnNDY3NycFl6RWpFYVkxQVdhWGFqdW0wRVFZeWpwNEhDTWR4?=
 =?utf-8?B?TWNkd3BMeHFmMUxsYmZWQzdhSzRVdS8rNi9iTDJCYzZ1NjJOSCtqeldYL1A5?=
 =?utf-8?B?YlVUQ2cvVTVWT1RZRWtXYUp0RDNueURKa0piRUZ2SXVsSGl2VlVlRlZ0MnJ6?=
 =?utf-8?B?ZUZ4SjF1L3N6VlNCaG1GQm5LeWZqV215MWY1a21NMlZHMS9BOE1SRVVRaGpK?=
 =?utf-8?B?emw1cUZoczhYSEVZRkhLSm1lQm11aWUyUUxFSlMvazlaZGtKWktPSE4xSzZB?=
 =?utf-8?B?TWNUN3BpbThSWUNaUWx5R0FySzNxMG1iY0V5ampDM3lwTUhxejliYjBYTm9q?=
 =?utf-8?Q?CrUjtj+2E0YOlhoI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9785f38-3912-4966-a3f2-08da4fdb2742
X-MS-Exchange-CrossTenant-AuthSource: MWHPR15MB1791.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 20:59:50.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQztvbJaR/vvVC+QbLtusNLCyrBdp4xHuDTb6wmO4DARVyhUgZVCQWWWeVWqgOIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3718
X-Proofpoint-GUID: -tejfqeFwkaqVzkU0gEqU4K7_PDTBtu1
X-Proofpoint-ORIG-GUID: -tejfqeFwkaqVzkU0gEqU4K7_PDTBtu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_18,2022-06-16_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/4/22 10:02 AM, David Sterba wrote:
> On Tue, Feb 08, 2022 at 11:31:22AM -0800, Stefan Roesch wrote:
>> This adds the force_chunk_alloc sysfs entry to be able to force a
>> storage allocation. This is a debugging and test feature and is
>> enabled with the CONFIG_BTRFS_DEBUG configuration option.
>>
>> It is stored at
>> /sys/fs/btrfs/<uuid>/allocation/<block_type>/force_chunk_alloc.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  fs/btrfs/sysfs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index ca337117f15b..4f4f038bc261 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -62,6 +62,10 @@ struct raid_kobject {
>>  	.store	= _store,						\
>>  }
>>  
>> +#define BTRFS_ATTR_W(_prefix, _name, _store)			        \
>> +	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
>> +			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
>> +
>>  #define BTRFS_ATTR_RW(_prefix, _name, _show, _store)			\
>>  	static struct kobj_attribute btrfs_attr_##_prefix##_##_name =	\
>>  			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
>> @@ -785,6 +789,54 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>>  	return val;
>>  }
>>  
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +/*
>> + * Request chunk allocation with current chunk size.
>> + */
>> +static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
>> +					     struct kobj_attribute *a,
>> +					     const char *buf, size_t len)
>> +{
>> +	struct btrfs_space_info *space_info = to_space_info(kobj);
>> +	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
>> +	struct btrfs_trans_handle *trans;
>> +	unsigned long val;
>> +	int ret;
>> +
>> +	if (!fs_info) {
>> +		pr_err("couldn't get fs_info\n");
>> +		return -EPERM;
>> +	}
> 
> Same comments as in patch 1
> 

Removed the check.

>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	if (sb_rdonly(fs_info->sb))
>> +		return -EROFS;
>> +
>> +	ret = kstrtoul(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val == 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Allocate new chunk.
>> +	 */
>> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);
> 
> Starting transaction from sysfs callbacks is not considered safe due to
> potentially heavy operations going on, taking locks etc. and should be
> done in the follwing way:
> 
> 	btrfs_set_pending(fs_info, COMMIT);
> 	wake_up_process(fs_info->transaction_kthread);
> 
>> +	if (!trans)
>> +		return PTR_ERR(trans);
>> +	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
> 
> Similar here, check the function, it does a lot of things, this is not
> safe from sysfs context.
> 
> This will need to be done somewhere early in the transaction commit
> after setting a new pending bit here in sysfs, like the
> btrfs_set_pending(..., COMMIT) does.
> 

I discussed this with Josef and Boris. Using a work queue to process these
requests seems to be more adequate then using pending transaction flags.
Any thoughts?

>> +	btrfs_end_transaction(trans);
>> +
>> +	if (ret == 1)
>> +		return len;
>> +
>> +	return -ENOSPC;
>> +}
>> +#endif
>> +
>>  SPACE_INFO_ATTR(flags);
>>  SPACE_INFO_ATTR(total_bytes);
>>  SPACE_INFO_ATTR(bytes_used);
