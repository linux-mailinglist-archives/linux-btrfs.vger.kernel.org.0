Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F447489071
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 07:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiAJG5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 01:57:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31204 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232399AbiAJG5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 01:57:33 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A1UuUk007475;
        Mon, 10 Jan 2022 06:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+ApYogqg7+mkP+2aIl86ZfLRLvzQytN1iWTV6k0xDNM=;
 b=ZM0nl5cY9UPkHiCf2gPrEHjMkYJvAibYzAwrTGbdeHYjWt8La1bDv/JL6dsrwGsAnZnZ
 xhxBiXdRGRVZlK3CFaSo0zfzBOkYNd627Dn+dR83ou8PqOtrV0huUSy7MN8H5HwqHNwN
 F8g6Kaud7rHtQrOi3jUoN3M0nDtYgMYv8ez2w1+xgTExzsJGR4wZ5YoLnQ3o3XkGugs+
 xl6W4yK8nzY+5Hsandqumj4XS8mnnSlaLTRc47o9Fcn4k1NtUmWuENIs6JtaeEfKB60T
 d+f2pO6Wub0w3lImAAc5iiCkWyczFoiheWliUHnReyRs8AP8O3FrnBnHMG46+2ksTHN2 EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df1d2tb25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:57:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A6tWua173348;
        Mon, 10 Jan 2022 06:57:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3df42jfy56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1McUTXSX80z2ARxopcxI6N+weMpAMu8qsArVK7Wk1FxrNbGpeL/uOqByk1QD6OsCaZAddiFretOzQJtLudF8a8qeP9miPGCessBbnRsAxg53q0z1sLW9c5zp3p4Hucrz1Ig9dfly1fRYW3dhnrUsm8PfEkwi7TT8TqVhshOX7L1P/T7bVfmGPc1Rf3QlmcaTnK1cq1FxbGFz/9JNwL6uUJwRNgQvpIwY6z8Ggax/gD4FyYKa++rqAmFWdKg/IurWsRQThSW+pQhLT3oT4xmYBihMbUGhFyOlXnkBAQYXqqMjFguV3xAM6KyUqbHopdC6ABWlmpeuu1CgBTg6Yn2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ApYogqg7+mkP+2aIl86ZfLRLvzQytN1iWTV6k0xDNM=;
 b=AfL2y3NyvPPZbxQL5fzcelDeFCLpSXclsIarS1bShFR7JRq2a+HReW/qYjZBWZYLqsyII+xZYqA/Fylx9MosaK87Fl5r7Ckhhrc6w3hIb+SHba81fyfAPBvkILCW7iyQMqqq93V65I5nFC3FJy9FwTJsO+bePeotveVxN1X7mn1E1QkqSIk/rWsKDNXr7Z0x8ovgz5cg/7CAjWCBIdS7CqyEqRBMoxlQy5deTr+x5rxN67cR65pg3nCsaPE2fNXhR9vqnIVbwrSYmZzZmef5JwYQ9CzNM76F4eVAytrvDKBVVZFVZC8k7LfaegtLJg5c/Up3DPI1MrVEBDIJlWTBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ApYogqg7+mkP+2aIl86ZfLRLvzQytN1iWTV6k0xDNM=;
 b=UDyliihek4+LJ1e/N/Fga5Mekfr5AsY8L7yQg1zpd9arsgRuMTLMMdlI+Ng1uTpX/Qz67xUallxKCS14DDWznjCt3lGKCHY4bzqbldWADO3b3e5iHDA4scieWPab+jcT5tEn7ggie+Tx/TPzt9nm6DbePAO2dZAkKSK8sI7EUCk=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:57:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:57:20 +0000
Message-ID: <233eabe0-a5b7-eb1e-6861-4ecd86817afc@oracle.com>
Date:   Mon, 10 Jan 2022 14:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/4] btrfs: harden identification of the stale device
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
References: <cover.1641535030.git.anand.jain@oracle.com>
 <e418fd929f03644b70c6be6a1b081bb97dbed254.1641535030.git.anand.jain@oracle.com>
 <20220107160603.GL14046@twin.jikos.cz> <20220107162120.GO14046@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20220107162120.GO14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97fa6903-6da9-41c4-cc61-08d9d406724a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5171F5E3504920E44AADAFF6E5509@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTgYgSNWY9d8qx+8yPqUIOeWCsnnTSnbLlP6s1SXj0W2DLPOGnBaFcwGE0hEoyy2LvhoRWZ9/kin+XGUXL4XbeDL+w0VwiVqgaHm1A4fcdkHA3wFg64s73edvC4EqW1OXi+8YGPCZl8LktqrIjAGp2dyDyTM8OW3ObyQLM2z1sn0/8o5Snn8xEWxclztxCbRex3USdIfXZpPUkmt5zAWNa8iV2EOIxhjSXwEX/dp5JOYYHGLueXsJKwBmYhrI7pXdF3solNT6KR1QiwYf6HWLcI97yfUNdt0jgBYiYSnLoEjeJd0mcMcqHELVllKrPg6jkeo+4EUFInyyP0s+XWptyaeZOqT5v8g2AEpmIZaESY6rrXJ+9978s0jJHOnmPMy69ZOrXH9yAwTwBaPSBTRfl8nmh9b/JewssBgUfFWF9ekXKqpfzzWlpXnVJ4kmZf1CjgvVUa0+sOlDiMXVE4cNAivTOIoAPNa9uz4nruMqtXu0wynrGvB7ldpnhnhaWPNnI/8m6pLiy+wMT2Vlg1y5tFT/6rxFJehB4dSbLhaePkL34OvrQuv3nqiGTV95iRpWgxKu+p0TGLUOF7eJ4fvAcwXq0+yRo8CD/MCUOYZrDGbsJM4IyjG/+Q7moVB9kYfckf4feYIayaB3IDi/aGleZwhYjPNtLHYxRMlF2w1cQXh+1Wu0e61jk+cK3lX7W1CszBxllRZqQ1cahjJ4B9Qbi8ObiuqMfswF+dDJ4mB06o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(36756003)(5660300002)(6512007)(2616005)(2906002)(44832011)(31696002)(6506007)(8936002)(186003)(508600001)(26005)(8676002)(316002)(66556008)(66476007)(53546011)(66946007)(6666004)(6486002)(83380400001)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWtibkY1UTJmTTNwZ2tYVDBoN0phbTFSSHFRY0ptVGFVMDA0cmcrVlZpci9E?=
 =?utf-8?B?a3ZDNEJyYjZHT2NlMEdjM1laOXhuWmU4MHlscTJYZzB1clNwQVFWWGdiTGl5?=
 =?utf-8?B?aWNlTUVMR2xYdk1MbERaMEdaSzlvNCszb3BtYWF4bDlVdTAxRVRaV0lpdWl5?=
 =?utf-8?B?ZUdVNHMzcWE0clF0NENBb3ZJTE44RnNEbEhQK3JGVE9lYm92QkJlWm96QTBt?=
 =?utf-8?B?Y1JkcW9zWWY5bFZiQzBZRTUvSlU4QWhlcml6TmVPWmtDZG5zN0VwMi9WMnp4?=
 =?utf-8?B?dHlheTFiUElxUlQzcVVFT2FEeTVzTXVHK2xVbHBqRGJLNFluSUdsdHNYanEz?=
 =?utf-8?B?UGNPWGxoQjl5TGt0aVFVbjVoYjVRdks0OGFWTkx0bVBrMmI3VURGWWdERnFu?=
 =?utf-8?B?VHpRK2lyajc5YStXOHZyYm1JYXZReHZ1M1ZmS0prcFk2ZEJ1VDRSeDRUUEMw?=
 =?utf-8?B?OU9QOGxId2Z6cHk4b1c3NGVNcGpwT0tXWW5GMnU1Y1Vsa2F0Smh2N1FwNFhK?=
 =?utf-8?B?THZDV0FXbzErcitOOXpwOVVycStZM1g5YlFZM1ZOVnNpaitoZGNPU1VpblNk?=
 =?utf-8?B?d2xCRjc2SXZRa21wMlBjTWNxRWJuck5WU292SGZ2YXBNNEVUbW1IR3A1TnI0?=
 =?utf-8?B?ZFIxbjR3UnFLMGI5a0ZOczZmQlUwZS9CajNDRXJvTnNFVzZUTkZCcW1RNStm?=
 =?utf-8?B?a1BJdFI2c2lWUVMwcHdEZHg4eExkNXJpWjZYdnNXdnFZc1FiSmRRM3p3VTdO?=
 =?utf-8?B?N0Q1YTVJeVJkM0RJZld5K1gyb3h6UlU5a1AyNHpCa3VteCt6SEswdHR3R2hI?=
 =?utf-8?B?SldER29TNit3RXJhcGZ6aDErNUJ1NjNBYTg0NXV4VlUvaUZHeWE0TVF0aXJN?=
 =?utf-8?B?SUFDWFBQQWhlbjJXTzNpOGJkSC9Icm4zYUxZUUZMajdlWDIzV0Vta3VGY01n?=
 =?utf-8?B?K3pmWUM5aGEwN0N2VGZUYWxFZitVeHY4VThScHhBYktseG80ZXlHMWwvM0Yv?=
 =?utf-8?B?bmIxazhBL25NVm9HeFNvRDRtZlR6aG1vaWk1dVh1STBaOHdLdkxRTm1jRktm?=
 =?utf-8?B?Z3FESS9RV3lDL2lWNlB3N2RHOWNpaXJBZVNoVkViM0lkQ0tyMk1KUSs5WWJM?=
 =?utf-8?B?Z2RRa1lPamJ1WWpjRFhrTFpVa01uOENwa0xKSWM0QTVRSVozb280RkNQQWgy?=
 =?utf-8?B?TkF0MXFOc2ZZeFJ6eFU2NjdiS051Y2dlV2h5azBybVRDTWx2bEFWM25Ra1Nv?=
 =?utf-8?B?MnZNOXZxUldoRGFBT0JON0trRnBQUUpoNVh3amZFT0NHbXJZS3c0eTJ1eFhV?=
 =?utf-8?B?TytlTklVSjN1TGlOWkZvZXZGeUg3NldkQjkvOFlDV0lpaHdranRsTWVHQkhy?=
 =?utf-8?B?OGlTWXJmZjBDQkpKTjRwQVVoOGJjWnJsK2Jub3lLbjRRNjl5dDQwV3JwOHF3?=
 =?utf-8?B?NXJhZHJKWkVRL2d1SlZWWE9PanYrV1Z1Y1NOdEhuMThheTRua2RtUFJaMzc4?=
 =?utf-8?B?VThxQ1ZDRmV5by9rWkNiTnBCQ25GRkxoSStodWxtN1VNYzFZRnV6Mm1nZ3JI?=
 =?utf-8?B?L01wRFo3V3JhSG52UTUweWVZaS8yeWpLMFdvdm9rMTYxL1RuMUNqb1Nkc0M5?=
 =?utf-8?B?SFNsZnJDL3V2R3gyMUVRbE44RnB1OTlWcU81bXdCYXIyWG5EV0NrN1VZU2lo?=
 =?utf-8?B?NDExV2Nxd1o2dHNEYzFOUlZwN1lmT1lVaFdjTmpmNndoWDBIdHlmVmVzbS9l?=
 =?utf-8?B?NE0wMUNjR2dyR3dGTFJPUFdHcmR4Slc0YUQzVWZnY29mUVVIbDd2MVMya2wr?=
 =?utf-8?B?YUhlRGhzWWZJWXg2d1JCWHVaZmZnanZQVFlEMkJ4SmpTVWNkc2s2V1Q1WXV0?=
 =?utf-8?B?cWtHT3RhcUxMNFY0T2Z6T2dFUnpJK21KL1E0QTZjbndZZE9BQ2dxTTdpUVpR?=
 =?utf-8?B?YXA2V1VQcG5PZUcwNHRCek1yVmdNY05VRXNaL2lKTTJvQlllVkNwcHVQcEhH?=
 =?utf-8?B?VU9OTllIb3FCYW9EenczMkgxL3RUci9YUXk0QU83ZHluK01GS2FaenhKeldh?=
 =?utf-8?B?Q0NLdVFYUlEwMXczRW0xMi9mRU44ZWl6cUtlV1JXRVQ3cVd2empVUi9OWXg1?=
 =?utf-8?B?VkZmSm1Gb3JUVE0xQnd3Qk56aEFjenMwSGRpenVmejV6OHRhVnBoTVlHbkJw?=
 =?utf-8?Q?EaGgGDOSgtJNBVz//436jNk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fa6903-6da9-41c4-cc61-08d9d406724a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:57:20.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivaMRMRt2FUu3LKws8RaUx464V53RJr1fZetGzY/FLH8DriUqBDnnI8xnuZZXBGuvR0SxflACxz+frD7Z7Dp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100047
X-Proofpoint-GUID: kPA7aeJCENGSlufiPalndsAF_mDXQaBT
X-Proofpoint-ORIG-GUID: kPA7aeJCENGSlufiPalndsAF_mDXQaBT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/01/2022 00:21, David Sterba wrote:
> On Fri, Jan 07, 2022 at 05:06:04PM +0100, David Sterba wrote:
>> On Fri, Jan 07, 2022 at 09:04:13PM +0800, Anand Jain wrote:
>>> Identifying and removing the stale device from the fs_uuids list is done
>>> by the function btrfs_free_stale_devices().
>>> btrfs_free_stale_devices() in turn depends on the function
>>> device_path_matched() to check if the device repeats in more than one
>>> btrfs_device structure.
>>>
>>> The matching of the device happens by its path, the device path. However,
>>> when dm mapper is in use, the dm device paths are nothing but a link to
>>> the actual block device, which leads to the device_path_matched() failing
>>> to match.
>>>
>>> Fix this by matching the dev_t as provided by lookup_bdev() instead of
>>> plain strcmp() the device paths.
>>>
>>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v3: -
>>> v2: Fix
>>>       sparse: warning: incorrect type in argument 1 (different address spaces)
>>>       For using device->name->str
>>>
>>>      Fix Josef suggestion to pass dev_t instead of device-path in the
>>>       patch 2/2.
>>>
>>>   fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 4b244acd0cfa..ad9e08c3199c 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -535,15 +535,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>>>   	return ret;
>>>   }
>>>   
>>> -static bool device_path_matched(const char *path, struct btrfs_device *device)
>>> +/*
>>> + * Check if the device in the 'path' matches with the device in the given
>>> + * struct btrfs_device '*device'.
>>> + * Returns:
>>> + *	0	If it is the same device.
>>> + *	1	If it is not the same device.
>>
>> The logic is reversed, as the function looks like a predicate, so it
>> should return a positive value if the condition is true. It's apparent a
>> the end.

This patch will be back-ported to 5.4 as well.

I fixed this in v4.

>>
>>> + *	-errno	For error.
>>> + */
>>> +static int device_matched(struct btrfs_device *device, const char *path)
>>>   {
>>> -	int found;
>>> +	char *device_name;
>>> +	dev_t dev_old;
>>> +	dev_t dev_new;
>>> +	int ret;
>>> +
>>> +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
>>> +	if (!device_name)
>>> +		return -ENOMEM;
>>>   
>>>   	rcu_read_lock();
>>> -	found = strcmp(rcu_str_deref(device->name), path);
>>> +	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
>>
>> Should this use scnprintf instead? That could check the length
>> BTRFS_PATH_NAME_MAX too, so we don't have to do strncpy and verify the
>> length manually.
>>
   Right scnprintf is better.

>>>   	rcu_read_unlock();
>>> +	if (!ret) {
>>> +		kfree(device_name);
>>> +		return -EINVAL;
>>> +	}
>>>   
>>> -	return found == 0;
>>> +	ret = lookup_bdev(device_name, &dev_old);
>>> +	kfree(device_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = lookup_bdev(path, &dev_new);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (dev_old == dev_new)
>>> +		return 0;
>>
>> Here it's confusing, it's returning 0 ("false") but checking for
>> equality. It's probably to be able to merge the false and error value
>> to the same check, but then the helper is a bit inconsistent with the
>> predicate-like ones. If the errors are handled internally and the
>> result is true/false then it's ok, but still a bit confusing in case
>> it's not used in context of the stale devices (where we know the errors
>> don't matter).

  Got it. I fixed this in v4.

> The last patch removes this helper completely so it would be pointless
> to optimize this function, so you can ignore the comments above.

  This patch will be back-ported to 5.4.y. It is better we still fix it.
  Thanks for the review.

Thanks, Anand

>>
>>> +
>>> +	return 1;
>>>   }
>>>   
>>>   /*
>>> @@ -578,7 +609,7 @@ static int btrfs_free_stale_devices(const char *path,
>>>   				continue;
>>>   			if (path && !device->name)
>>>   				continue;
>>> -			if (path && !device_path_matched(path, device))
>>> +			if (path && device_matched(device, path) != 0)
>>>   				continue;
>>>   			if (fs_devices->opened) {
>>>   				/* for an already deleted device return 0 */
>>> -- 
>>> 2.33.1

