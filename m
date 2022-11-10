Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95033623BB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 07:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKJGWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 01:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKJGWb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 01:22:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4642E9CB
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 22:22:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA6BwsJ000512;
        Thu, 10 Nov 2022 06:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zwqm4Fgn39y+jfliANQMlV/9RRZiLJxT8JQolszQSPs=;
 b=c19eMhQvtxt2740PTnpW6CDXdmf5S+V2Mykb9UdCf9NcnKKTTK3nUeengbXdgP/l0c9M
 yHALHuifeNeCKiYHh+qRFukrMJvAZsKMX9tfu+E1w8DRoz3R4ymq/6TK/DZxBTTXP90q
 Lzm7kxqWcpIcJRWQfj7DvCC3e1GG/aAoVt4TOCSOPtUQECn5fLM5+BPolS4f8SF0YsQ4
 Bskb8Z5+ohU5fYlrra0g92igybv7++7w56Lsdm3MTuhHUCAAPXXBPs+Vvd+6Wc81WJfD
 bDAxEp3ls1M9YXPww9xAUjic/pcK6rHBQq0+72tGG4On36keT02qLEXdG4lySfjgNq+Y 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krutr80gq-26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 06:22:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA4OmKg004321;
        Thu, 10 Nov 2022 06:06:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq4eye4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 06:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+G1H/zb1kzD28cOqVOk6n1ofcK6CJvNv7HydoMbj8HCIBLmkDBBCrfxDIZfg2n2M46BU56gKD5zK5MV4cG4jPBIqdvDjwZVX0FtHlSp3Ws9SpidjOKES8FHu4ZMPBSDLv9SAxBk8197sfnpYY5/FQ4G7whK0uuija3BvlOEi0PrByMQDToLVb5fJdIdlOz/g12DXzOZ4cdc1WTTJ4N0Q4iYp+PTzoqr2CgBU0RaRKUNTtbXEBSNSo2rFomuf7sDlsUMb7v93Oco9OB+PwBNbk0++V8LTjoJQ81yB0MjODJJ6vlhm1TN+tRE+z4Hn9UFHOZO+fCV3SMJ8T6twPpv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwqm4Fgn39y+jfliANQMlV/9RRZiLJxT8JQolszQSPs=;
 b=WR4MOe7f+CtHUa6Sk+EkEfbT1M8uwZo5ersLGcC5YNbLjKzf73BQkQZhmZ2sn8wQYxPToupYlSBhzrQwWlGF+MBMVxdPHHid37W/d9vuCgi66rvgl8Rl8vcraYZ2aR2kbpKb1mn/Gszgda2N/N8dn0JiRiAnwI2PwEzdTXtAddx+C2a8LhtuTrrY5KpDnG7ckA7fXiyMGcAac2wsFDw5ATXHAFdPFVAXIH0IYyCgKzhn/QmkPMs1LkOiy8FnIV08+eTpurnEeJpRv3X8aNI6YAfphH8zTqOLHjstIubcsqMU8fwSLDM6PyQ3xuHXMS66Sx60aqhgqU5kpV+yNa11Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwqm4Fgn39y+jfliANQMlV/9RRZiLJxT8JQolszQSPs=;
 b=qZr+jbVjIe7Vze8j/4CxtBPt7e4dJQPUUIfZRymybXHDdTyQSLdY6az2q1LkMoTq7YIJxJ9vpba+XzvgFRAj3OOFeUJYtFl3ehOnO+KG8YbGL9flGf1T7HVaUnyG9RmTQo0XXJyGwnbZFXs+Up6yNyKXNbfj60sNqJjRnkmyV4o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:06:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 06:06:21 +0000
Message-ID: <b033fb75-ee1b-40a2-2c2d-9dee38c74ab7@oracle.com>
Date:   Thu, 10 Nov 2022 14:06:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: drop path before copying subvol info to userspace
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <3d46bd74955e2087332e492a96f6da78ca4ed533.1667898218.git.anand.jain@oracle.com>
 <20221108143751.GA5824@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221108143751.GA5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: e749ef18-cb58-4656-1ffa-08dac2e1af7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECPp99r3znOMhe1sanuIovc/dYEe49mSm1fYyggaDmvyeWcy72fCfre5OT9cC1eYQOFIeyRCCKMJ5T6DM03J1KENoV+QmnjATwUiFQkC2N93bbIo2Jcj/tKqGXpIRShY58TGW4HeUfOKruDt9qIJpcvtrA9FlyUgX380pxIxK7yKA43ypDDD7VLi3Z3/sr1Ol5rtJvGX+00Q7XAzZQItnwS77+WvBKfYeQUvJSUyJXpm/mahPOg7xNRW5HIsGMMV1MRCxQwAJWiIlujSKqamDLoP0N0YSEC4g8z5dCT69z0UFDbVbi8aG53358dt2xLwfF72j19HJXUene3BRxwNPxbw1OaKcZIcb0OkXMBi5xrIP5KSkletNX8UNKyxvPUAJDXRXVJbDMFkJhO24etTRi+m0CAMiYp2SJa3Iu9sdPThSx+HeOFHza7uzesvpjq7NiZKQIvZHr8UaC7KtZael+k9tauaJlkJTGB90niVISlm/YjKpCiqedtiKFaXKApNIMzYd8aCzl54ADfbIXax8/L+bWXpxhy0GOzkBAtuu96JX75PhUt4NOTlkxndpl0woMPMQcSnxn3dJuHtxh5eKZxm05AKfoN2nzC5gURt63hfB3TEIAZ0aGBJmj33tTRD4jja+Wxqq6JOd89PbcepuDKqYqRg3Q62auEWV/qeokmiHhPn1tBZ3RU7/Td7oq/CMqY2X5oSaUA0xMYavm7y1kQNlHdHd5pTgN5vSxXgdOGejOWjzDRMty4IaNL131nVRFK2HdKZVbGy4ZriQnw+G0UsCmia5LOrxUSATq+/HAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(31686004)(6666004)(31696002)(6486002)(44832011)(36756003)(6506007)(4744005)(478600001)(38100700002)(2906002)(86362001)(26005)(2616005)(186003)(6512007)(66556008)(8676002)(66946007)(6916009)(41300700001)(66476007)(53546011)(8936002)(4326008)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpUTjlaaDBWTThiT3BvMUxiVFQ3aXJzVUh5b01yWjliZW14Q2IrNlA5RXR6?=
 =?utf-8?B?Y3ZJOWpvUEdDc1pLVkZYTjEzZUhRSXI1eU9wZGpzU28xVGdtRnFaZVBvNDN1?=
 =?utf-8?B?clNKVHhNTWxxOENzMmpRRkp6QldITWtYNlJjL1FPVGUwK2VvWGszVDRVSUhC?=
 =?utf-8?B?TVZnWVdWVy92dkh3cldhMnBRQTh0MDFTNzlCZGpERlpQeHBXaG5SSkJLV29O?=
 =?utf-8?B?RkU5SWNTK2ZOaXJCdVVKZU1JbC9FcWEremRjTXBlSWRWWnIvOE9Rc00xZ2Nq?=
 =?utf-8?B?WXM1c2krckJlTG51eGlSNFVzcVVKSXpqK2ZvTEhmS0lRT2cwWFM5ZWkzekZ0?=
 =?utf-8?B?ODVHSUZHNzcyQ21zbmp2a3RQRmNOVmRXOXppL3RqcjFtbVhLbXFyOHlyamM2?=
 =?utf-8?B?OFhJK0ppdnV0MURTZXNsU3YrSlF1SUd0c1FxUTVvdXBDdXRYVjVtWFVmaU50?=
 =?utf-8?B?L1B0T2RFUmYzYk9odjFRY1MrSGNuQzI2Slc3cnlGbkRpMTdwajlUQzFHeDFV?=
 =?utf-8?B?VGxuQXdRbHB2U0dKTVV3Zi9hQTRIcXpCMmlydnp0WEtyNjR3YUFRcVhPOHNK?=
 =?utf-8?B?Z3Ywc3duMnNTQUIrMTRGZDF5YVdoTmZzSXc3U1RGNlo0R3A3amh5RTA0dlBL?=
 =?utf-8?B?eDRyUFNMRXJrdDNTQjJSeUxTdDRYSzNzVG1QUGJQMGZsYW9UWWlPcktlQ2NH?=
 =?utf-8?B?N2FGMXBKNlNSK2lPUGFPaGlRSFBCZURNOWZ1NU4zeWkvbUJkQ1FsdmJSOEpQ?=
 =?utf-8?B?b3RTbDNlVlNQc1VOcnlFZnZtM1JpYzdOS3JYS2RhN0RDOVg3bE55VlpYNUZ1?=
 =?utf-8?B?QXNhZlNhQUFlY3JxMFZWaUVXaURSQXZwSW5oTGtzUmh5RHh5N2RrRGlQQTNr?=
 =?utf-8?B?NUNkc2k4QkNOV1dabTNaYUFBSVFGdUVHNXNxTFJsNEZ1Z3BKL0NaZytUWlFN?=
 =?utf-8?B?YmVaRGd2cFVMRG9QczlONTVtTEFtcXB1WXpWVmRpZEVtd2dWYUo2aXFzc0hD?=
 =?utf-8?B?Z1ZDT1A2cy8wRkxGcDdjOXp5NnRvWk1EdmM2NEtVblNBajY1NXRhSm13ZC9a?=
 =?utf-8?B?M3NiSHV2U2FJVE5qMUJvRnFCRjZwaTNEeHI5SklZUWNaY1dqaWVjTVVKNGY3?=
 =?utf-8?B?bjVCMks5N0h3ck91dVBCeWhkS25EMzZFY21tZXd6SzFmVnZTU2JJUURaVDZI?=
 =?utf-8?B?TXh4a2VOTEMxZFRTbmkvU0pzNVZvQzV2R0dlSjlwQ0RqMXBWTE0zSnpJVFlp?=
 =?utf-8?B?alkwNUI2K1kvdHZyQTVwRGhSVlExeWlRalBuN3UzRXF2Q0ZkaWVQQVpwVHJv?=
 =?utf-8?B?bms5T01nMXlHMDUyQjdrdndJR3JQeUdHQ0pHWnRQQW9yaUpDbkRRZllsT21P?=
 =?utf-8?B?YWtHZzhVLzJPTGthbEZoR0l6Si9pUVJHTlZTLzBNRlZKSkIvaStpbVVlKzU4?=
 =?utf-8?B?cm5Wenh0KzVBRmdvVlRxYnFGQjBZb2dHRmZFV2k3bGxLWklvZUpGd1lRUU1x?=
 =?utf-8?B?YUFIbVdUOXZWSG1qem5mU1pDMzlWN2F5KzE5TEpTYThxY3Y0RHRjMlNNbmlX?=
 =?utf-8?B?Sm83cDN4WSt2TEhNYmtGTjB1UExmU2xiRllYeW0zU3U0bHA3U2N3cVRLNlRj?=
 =?utf-8?B?Q3RESnRGMzk5U1BlMVp1eE5XVDRPL0lwbkVxS21kSjZMRFZMVW95bXo2ZENZ?=
 =?utf-8?B?ZHpaV3Foekd6TkpqZlJZNlpheEJZLzYxVSt5TXg1Mmk2Z1pNQ29lb0krakln?=
 =?utf-8?B?dHBtaGNWcFJTMG9jL0ZTMmlHYTl4Mmc5VWl1OHNJYmFnVkU4YlEzN09MeThF?=
 =?utf-8?B?a20rdXJXL2xueXZPSW9pbTBhYldXZ3U2dGNxZTRJN1BEYWtNZzB6WTAwTFZL?=
 =?utf-8?B?TmhGWW5LZ0l2Rjl1d3VCVytyS0NtN2dKcXFEWGIxMDU1UmNkOWlOQVpUMEw1?=
 =?utf-8?B?ZnRYb1BibnZtSTVteUNYTFlBczU3TlZFZUZ5U0xSWUhsRFVwWlh5ckhncm1T?=
 =?utf-8?B?T3oyMlRkcEFGTWtwandSbjBTYTBxYXpoZFI3VFJXbjR5VXJhTnZqY0d4U25k?=
 =?utf-8?B?ZGRTckIrRWZ4SVJJSWJJbGpuek1vMzJIWE9DaFFnN3ZFWG42ZkJQMkx6M1hK?=
 =?utf-8?Q?zjuL0BGB2qUl0AbXjz2NO3zf8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e749ef18-cb58-4656-1ffa-08dac2e1af7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:06:21.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9olBSYODLlysyXvsX2uw06v93hkR3eQPhaX6hxrvog31dLKr3CzsdZK5CpIkhamYmh/8YS736AHRpCsrfAwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=826 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100044
X-Proofpoint-GUID: iSedMwwWrnZKv_CUJVHJHtwWogjJCR82
X-Proofpoint-ORIG-GUID: iSedMwwWrnZKv_CUJVHJHtwWogjJCR82
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/8/22 22:37, David Sterba wrote:
> On Tue, Nov 08, 2022 at 07:23:19PM +0530, Anand Jain wrote:
>> Similar to the commit
>>     btrfs: drop path before copying root refs to userspace
>>
>> btrfs_ioctl_get_subvol_info() frees the search path after the userspace
>> copy from the temp buffer %subvol_info. Fix this by freeing the path
>> before we copy to userspace.
> 
> Seems that there are a few more ioctls that need to be fixed:
> btrfs_ioctl_logical_to_ino,
> btrfs_ioctl_ino_to_path,
> btrfs_ioctl_get_subvol_rootref.

Right, I missed them when I glanced.
I am sending the fixes.

Thanks.

