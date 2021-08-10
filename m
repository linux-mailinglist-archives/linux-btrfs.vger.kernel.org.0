Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51E93E505C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 02:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhHJAbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 20:31:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41996 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235165AbhHJAbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 20:31:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A0GmmV021464;
        Tue, 10 Aug 2021 00:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o1y2DgrWV2Cu8uRu1uUgWTP6M9I7n/8vvLglA8srT04=;
 b=WlpqJAWt4PhpYzxMVirU1xBN+psBL45140uxRVFU7UdUVZGXCriKDg/fg055nba6itcV
 zuCJd0skG4KRC+6MZtoJITtMoGRaNCvjErX1YHbvm2D5rCOs7nKO6ekAutsZ7dcdGOMw
 oPQQh1PKLTzijV9gUfo3NkuChtxt80iJifgdK9oAp9gdqfm9k/ndg2vGaiWLZ7Y5cxJ3
 GesBJYtV4AMAov5l5zHZO/qaTP2tdhnOnma/6XZnT0ueu/o5g8fNpVDABApgNf/LPaWr
 TO9ye4qxPoHN2H1y/qvWE7+gz45cWzvssGvnk+UJBwU2iTZ2JBYS9lYlCzX4KJkeMKbk wA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=o1y2DgrWV2Cu8uRu1uUgWTP6M9I7n/8vvLglA8srT04=;
 b=U0b6Ok9Ra09ulXTu6RENPMHRVVF22cGPJupzoY3iiSgZOxe/HlL1nk0TORCj6jfMTuDG
 nEuj+Ej+7knHpwuHp8ora/arXXfHeVvo/gAafYQhBT1oj+MWney152wI2jOeGxt7Fw0l
 iV9ojMd3fQSVQ7A/DKHQtQRMid3qTPnsMpfpJe5+B3bScmrVUc82hkynG1ns5ZCLpNt6
 Tk0K33CoDUaMtU9rxd9J6dQZ1S+hX1eb6IQoA0L8f5uMMjp7JMtqb0A+PVC58PMrT1fO
 uWBn7qyrxlNiKlcVyItAZwuz96RXKSFZMT+7WST5GhZzGGORPSk/TMIxS2NWKxjelGhv pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaq8aan4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 00:31:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A0MuCx096310;
        Tue, 10 Aug 2021 00:31:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3a9f9vwrt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 00:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckMFMMbWCiJsQrXc6xGVnhOLp/sTfrRx/HpC14Cjvo6ElYraKgO+fbX8yg+8IDc051kuw2w/PnzYnnK+2MsOvIMOiINi3MLHqfliYnfS28+GWIb3DK4Y5c2yU8lL5AX1uWF+k9PcdTeKCtbaGFmZ1uA/SifbRA7WsufPRNwcCrGreQIM67QC4PeBVQSyPxm0MG8HZmKqFKSJ3P1QwhV4Y86R9Qk6ATc2dKQy3XJlf15QDU8+vSJ/0pPKILlVs3egwR3IadJ9WbIf9C6Uohpko1OGU+Ka5WgLF4VXcf/rEgLCKUnLGYhLhgGuyhbuzpLJqWrR3fIh4SkAm5Se1M98Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1y2DgrWV2Cu8uRu1uUgWTP6M9I7n/8vvLglA8srT04=;
 b=aJffUVwuBYzfugbN84YbQ9RtQW/2EsIk0rs7tFq4IrrmTlB1FrrIP7TsjHpnESVBNVdbQITQIAKNkscqmlRouB1KkXEbZvcjOC30sCd0gzqoWhwB9BlZLFT2wVyHrPl++98T7YPRpbwDBgL0VAHQsyKCdWq0zP5gT0CxD0l7Plcuyh/o12LUeGNpNTpfKUC2BM4KjNlSut3wqzplEXVE0MOqJOBztptyJohS33naTv2t0orRi2XKDPPRrRbcoSCygEjImx+NxjjA6KM1HtfhbzFY/T8kHvm+idnmwhpe1+wW6Y1B03jwNina3DeOr6sgx7sya8ccJLqzoIAZdCepdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1y2DgrWV2Cu8uRu1uUgWTP6M9I7n/8vvLglA8srT04=;
 b=p7/uxXmLw4N25kDul5QdS5/Owbm1mzlOa/+YeTFMANlpv4AHZXTV6S44Ny8YPQQFt8cC/BmHvcM39hEBfs6qpw0mj57g2tsWzBj+dcWlHsBKFzA6U3cdChzAQVVgd9eUC9KtGrv33BnkjbRuKlvn64SlQWRdLm7EaDgGEawIs6M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 00:31:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 00:31:00 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>
References: <20210728165632.11813-1-dsterba@suse.com>
 <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
 <20210809091916.GJ5047@suse.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
Message-ID: <a246559d-8eed-7885-d20e-df651d73d146@oracle.com>
Date:   Tue, 10 Aug 2021 08:30:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210809091916.GJ5047@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:4:90::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 00:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d89ab4b-47b6-4cd2-400d-08d95b9620ff
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5156B63FFAB673253CD3AF47E5F79@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hinEbGvE8UflndMZX+1l4Pd5QNeF9J6AobvOGOPN+gSLCX4LiZo81wOszpIvR/WVp6uvjG8+24sGWgaPmIdDh9T88L0D2N1LiypYd24hrFxBS2fgnF5KEA20eQHc+fAWN8AcWJhPa1wCX582ocMWKPUWK2HWq7uwaM1aYOzVJGdCCNKefelFQKkvzeYF+MZzzy+KoQnLn/BWjCBUYkJHqNDSupO6aWeaOdpawxdqNVq9CQrp0L46qicfTwY+GBeKiBKhDwLBTft9MuwHzA89VNmc1GV1NuAg/Fq/ci/pfzXkGBwqqckNRBloQACJb/SMFOiwiB8NNuYsYL46SoEYQqPasRDbvw7iOrt4QTCGS65t93EmvOX8zjImP+9sfXUBm+KM7CB6+KGwLkG0E3n0aoPwbxn0wf2JFHmtIn3lMHfou0off53jZvZXaYgiGQZUOfyVJMshBBAuRqkOfM1OtsMwhDEqeBf3+yArp08JG8+FO6KysL/53EeTcgzXIiMdWhGe1cg3KyLL9tginvIMJpgL1ke+yzEwlKfbRbkMxU5yLeyeYf0RYkJQf6Iox+SUxOJ0SGluCdUjRwOVmJhdq4/Lrp89cDZJEuH9IRl1e1gGax2uKMvXfAZcRE+XJaWcWdC5AmKv8qdlin4YLUseEUmMuXxK/TPtxRzY7FCa772rSE2Dq3dNkHShP97qh0FjL31NtIrbG2YoJJ197nC2wsqLsnMrs+FNqw5LvBPAD9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(83380400001)(5660300002)(66476007)(186003)(2906002)(66946007)(53546011)(26005)(316002)(16576012)(66556008)(4326008)(38100700002)(478600001)(2616005)(6486002)(86362001)(36756003)(31686004)(31696002)(956004)(44832011)(8676002)(8936002)(6666004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pyMFhNV0VJbW1vV0l6bVlyVG1uQ1g2T0t5eFRpNWZONDJaNW9rMkl0aTJm?=
 =?utf-8?B?T0VIS3BkbmY5ZitWUHdkZ0NzRTJSN3h0MWx0RkhJN1c5Mks4NWUybzdVQmds?=
 =?utf-8?B?Qml1RU52VGQyYWxVUzFjZTJFYVhHVmFSS0VUUTE4UWdHQXVidXAzQ3NBUCtJ?=
 =?utf-8?B?NkVXZWlSNlhEeGlzMG5rbXV3R3BHV2JRdThqZVNRa2FXdVFFalB0RDU3WGRR?=
 =?utf-8?B?WndoSzV4TURFMU4rV2NIQzdTdWNsWkRFQjhXSjU0Y21pdzYrOG1ocUlTNzdI?=
 =?utf-8?B?VlBSci9pd1R5VTgzaWM5S0JiQTIzSzJTQm5qcUlKczR1UjQrMmlNemZwcDRL?=
 =?utf-8?B?NlpxZWkxdUFDcm9iQWI3a0svZFBpMVdpZExyaTBwZmN6eU1lTEsyQWd3NXgv?=
 =?utf-8?B?UHNld3B0QWtxK0syOUtwaVZmemZ5L2V1Nk1NQmUzem4vblp5Vmprelc0NHJt?=
 =?utf-8?B?eHR0N0JpMkxSdkxDdFBUZnVXbDJ6TU9RUHhyL0RHZDVORnl4eStVemZoK0tN?=
 =?utf-8?B?Z2I5a01Ec2NxZkQyc0pBc2pMZzVlbXR1UkRqSTNFcTJiMXphSHdTT2xJOEhM?=
 =?utf-8?B?QW43dG5RUFlXRldtL00zUVBEWWgyNGxQbDEwSGdtdVNYQ3FXL0F4Q2hkMDBB?=
 =?utf-8?B?Ykc0Y0hOa1ladC9YL2JLaUxTaktCc1ZXMUJtSXBINDJLMXJ0QWprQUJ2cnRn?=
 =?utf-8?B?cXNhU1B6UFBicWt6Nk5SOWMyZUxKbnljc1pGMDdSekphMlRXSGU1bzVZR0Mv?=
 =?utf-8?B?NXVuNVo1Ny9TWHdNNXozK0cvSEkzU01BQ0E3TlAzMVp3R2ttdFVOT3ZsNStU?=
 =?utf-8?B?UksxWTAzS1piS3hjcktGdnpzWjBkTUw3anhTYVR1WjZQNWxuNTY1SlhuY0dM?=
 =?utf-8?B?VG9FRzZIWitMN1Vud20weVU2aklHMUlMSUljMWNFSDIrZFRDNmRnQ2MrbmVR?=
 =?utf-8?B?SHB6S1Voc1FKN1dXV2cyckdsMVNkOEM2N1g3a1BLQVJFVkd6ZlY0RVh6dU9M?=
 =?utf-8?B?amNLaDFDN3I4K1BhM3JqVEdKeCtNaExieVFheDRZV2dOUmFBdktpUkJGNzhm?=
 =?utf-8?B?WklzdmQyR0ZpVW16dE1lTE9iWUZub1U5ZitYYmM2RVNCZWkyLytFMFRuN3Fh?=
 =?utf-8?B?eU9Vd1R6RGIvQ2k3YkhtSjV1ZU8rcGtkcExuT2x4UXF2cTIyRmN2d1paaHFR?=
 =?utf-8?B?WWVncHZqaWFNcUh6elllMkhtZFRwLy9LUHM1eTZjcStCRkt1MjhldVVBWm5m?=
 =?utf-8?B?allJUmdQU3BHR1I3WnErblh5TnhMSWF5VDI2cUorSndPcy9leTdRTEQrdTFx?=
 =?utf-8?B?M2U5RkJkQk4wbHlQQUQ5RjlkaDRvVjVXRDRrOE5FWEZoRHF2ZjhCVWpMaHlh?=
 =?utf-8?B?K09CZ0dyYVpxOUxtREY1N0hUaWRrcVFyTUlmNlJUdkhXNkVSMzlTenRqUXJW?=
 =?utf-8?B?RFIzb0J0UHp3bWxOQWFPWjRSRWpoLzVId21PVGRuYXdzMWJwcytGckFRZEJW?=
 =?utf-8?B?Zjl4cElDYnhxL01DZ0crWXBiZ1hwNDUxN09OaDJoVFN0SDF3MHUxWTAwRjB4?=
 =?utf-8?B?SnZKTkQzRFd3R3I3ZXJYalM3RVlDYjJ5MDQxTERsOVFmVlRhY2poUEZEVW5O?=
 =?utf-8?B?dkZ0QnNEMVJLamVXaS9BUndCcUVwYk5GNnNHcG1valJ1RDcwOGxpUExyMUZW?=
 =?utf-8?B?MHY0R1gzb2pXWmxYSzU2WVprK1RhTHl1R0JwTDZnNHlxZkJUM1dWTm1xRnBT?=
 =?utf-8?Q?WueIAK3aJZy36BxhnqI03W1QY+AEpWFqi8/6QDy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d89ab4b-47b6-4cd2-400d-08d95b9620ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 00:31:00.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MQjBcf1vFDEMeLpkUtfZLFnqFK6PwMs+OkJRCyeEyqalsAT+q/gQ+U8qvaqbpaU6/4fasdoqTE3iz4yryFWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100000
X-Proofpoint-ORIG-GUID: l1FpdFXOpnjxUPimKnEMHG5wQjzVyIhZ
X-Proofpoint-GUID: l1FpdFXOpnjxUPimKnEMHG5wQjzVyIhZ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 09/08/2021 17:19, David Sterba wrote:
> On Thu, Aug 05, 2021 at 08:13:03AM +0800, Anand Jain wrote:
>> On 29/07/2021 00:56, David Sterba wrote:
>>> We've hidden the zoned support in sysfs under debug config for the first
>>> releases but now the stability is reasonable, though not all features
>>> have been implemented.
>>>
>>> As this depends on a config option, the per-filesystem feature won't
>>> exist as such filesystem can't be mounted. The static feature will print
>>> 1 when the support is built-in, 0 otherwise.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>
>>> The merge target is not set, depends if everybody thinks it's the time
>>> even though there are still known bugs. We're also waiting for
>>> util-linux support (blkid, wipefs), so that needs to be synced too.
>>>
>>>    fs/btrfs/sysfs.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>> index bfe5e27617b0..7ad8f802ab88 100644
>>> --- a/fs/btrfs/sysfs.c
>>> +++ b/fs/btrfs/sysfs.c
>>> @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>>>    BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>>>    BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>>>    BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>>> -/* Remove once support for zoned allocation is feature complete */
>>> -#ifdef CONFIG_BTRFS_DEBUG
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>    BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>>>    #endif
>>>    #ifdef CONFIG_FS_VERITY
>>> @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>>>    	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
>>>    	BTRFS_FEAT_ATTR_PTR(free_space_tree),
>>>    	BTRFS_FEAT_ATTR_PTR(raid1c34),
>>> -#ifdef CONFIG_BTRFS_DEBUG
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>    	BTRFS_FEAT_ATTR_PTR(zoned),
>>>    #endif
>>>    #ifdef CONFIG_FS_VERITY
>>
>>
>>    Looks good until here.
>>
>>
>>> @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>>>    BTRFS_ATTR(static_feature, supported_sectorsizes,
>>>    	   supported_sectorsizes_show);
>>>    
>>> +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
>>> +{
>>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZONED));
>>> +}
>>> +BTRFS_ATTR(static_feature, zoned, zoned_show);
>>> +
>>>    static struct attribute *btrfs_supported_static_feature_attrs[] = {
>>>    	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>>>    	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>>>    	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>>>    	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>>>    	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
>>> +	BTRFS_ATTR_PTR(static_feature, zoned),
>>>    	NULL
>>>    };
>>
>>    We don't need this part. btrfs_supported_feature_attrs will
>>    take care of showing zoned if when enabled on the mounted btrfs.
> 
> The idea is to put zoned also to the static features so the zoned
> support can be determined before mount.


  As in the proposed patch which adds a table to figure out the correct 
table to add the attribute, adding to the 
btrfs_supported_static_feature_attrs attribute list will add only to 
/sys/fs/btrfs/features, however adding the attribute to 
btrfs_supported_feature_attrs adds to both /sys/fs/btrfs/features and 
/sys/fs/btrfs/uuid/features.

-------------
  btrfs_supported_static_feature_attrs /sys/fs/btrfs/features
  btrfs_supported_feature_attrs /sys/fs/btrfs/features and
  /sys/fs/btrfs/uuid/features (if visible)
-------------



> 
>>
>>    As of now, this patch fails with
>>       [ 44.464597] sysfs: cannot create duplicate filename
>> '/fs/btrfs/features/zoned'
> 
> I'll have a look.
> 
