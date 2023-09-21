Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D57A902A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjIUAde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 20:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUAdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 20:33:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E24B7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 17:33:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJc3m023171;
        Thu, 21 Sep 2023 00:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mLWXbhg/IRm+B+vhcN0LihRm/rFXwu6pUOq4h7ikE6A=;
 b=BEArHxIcuXxFpChc9xAb2Rgermk6adb5jyDND0Hiv5/iTosUwqik3h+pM50SaA45aYr7
 P7gMNpT9Q7F7O+dQR0dWlrgRii0G1mJlyiwlSYr1rHLvu5qfCxE71b/zXbkeWFZShJYW
 KRjHnJGE3DMnPKxNJWJjfrXBjkMkvwY2AQLwMPWbggAMdmo5p1cFOqQG0pRyaqeMMiLA
 fVoZnrAzbBPlOh6Y1dToI1vq30DVYXq+KbAkzM/4HRL1dtvgJz4FoAKcpnPyl2RNqDUx
 SwAlI4tQ98+sEnaDWcfsIVhtzK8R4WF7llVSh7Ls/Pl4yHRzaps/YZyLhlE+S+f1Cv3T Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bgh3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:33:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KMrilB015889;
        Thu, 21 Sep 2023 00:33:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7jrpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtuRBDUwybBjHYMOJtYs7+NQl6j5ECgIGFmYp170RiCvVckPD4Qd418uXE6i9Hxe6CS0T13eG0J9Doc2ReIXwGjR+wgVK7FTVJAf3VbeYNXUgVyS5w3z7/v0GK8SM60jc0ZGj7mUSf7FO77sN0Ydms6xTnFGWFxHWHW4H2leCfT8b97QWueOJ+6AXbKiGZHaXlPMqGAWZV269qmzqqHom2HKJg0x6qTGVe/6y6a0SfPHH7uKOxcqKLDH006HT+tlJky6st+8Csq/wUUZqbNa8NriaM6uhgwRyCiYdg23lUZbUmzbR0bTgkMNvLCkqGKeP6hEYxPqZpKrTjuG1VEtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLWXbhg/IRm+B+vhcN0LihRm/rFXwu6pUOq4h7ikE6A=;
 b=c1yKQy1YrayPYYnUpPo1BFi5wpsp4jDeUNOoITdizJWKyTrxuIEBya5eOC1kXBfC9TjlGJ9Vva7Cy0E9RrNYwv7fLHbbOlJegtmx0VcquBKM073Kn5MLXs6rTkkLdoOxMdv/q/41yVLiB+dBDVFXlJvaRRcxuUlL6W4Uy6M0+lWoNPxIEDZMu889zHQMLQANcYGk+dJWhEZY3xO01r6ttemgTfwwK4VTSmCvWs+O21pUvRH7z2B1RZSULnDfpUNcCVvZhDBa5RXqpdWyeWwZXsykGaes86sjUnOpywlRVj7fXVh5qJ+4Ssgmbg9qtdn0SiodjpBQVtXMYc3BSD7Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLWXbhg/IRm+B+vhcN0LihRm/rFXwu6pUOq4h7ikE6A=;
 b=G2tCKHod906uXoXwSD5TrclbaIZkSz6wdMA3fWCtcUl8cSCc0QDBdKtQSY4K1mug5NeiaVdjCspN9mfh9tDZTpeT/B8Dm4mzKGbjsXXraaw2c4fjP1MrBLjIL+PvoYvdiLiJsR1GaaKS8jJxzSSJIEoFZP21SHh7i0a6X0c5vjQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Thu, 21 Sep
 2023 00:32:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Thu, 21 Sep 2023
 00:32:59 +0000
Message-ID: <51ca231b-7245-354a-a7d4-0449000ea4e6@oracle.com>
Date:   Thu, 21 Sep 2023 08:32:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/7] btrfs-progs: export btrfs_feature structure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <512e1bb1572d5ffc3557a86a4ce3860420352214.1693900169.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <512e1bb1572d5ffc3557a86a4ce3860420352214.1693900169.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4333dc-5a9c-4838-8539-08dbba3a4ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVULpyJxeLFv4nfpp6ObFsxtajYGA5ku9T76ZtUa5xO0pNigaVSNXLb/FhmtXk9ES22ZgLe4dCb0AwVLrep4pubopeNtmRPUlkmoo1sPF/PUfGcMpT1++mh/Rf1qf7r2Uv68Qbq/8eH10//AXS5IZFSSd51UGLX/5sZv1TZHbqEVGx9h5TBZn9Q4m7aFkoA2jhNokQYKc+JgopsRgUgxsAvKhhkMqmRFNT5Hc8JRHd5+le2AIHE+dVrIY1mNo7m5pgp/skFMmqONOqX5tw5GoKZC5YZQ+af7+YmU5Y+jvPHToIO6WC+JM6ZfrATnZSIbh/+Fa3zY+6UnISxZezZek3EBBJ6+fYs98Rd7t/xNtJuoEks5FTvmKCVGsOOeF3NWR8Pczh45mpO4aLLAwPvBpY7SOatBJGZIrFdKltOkkCKWNnfX3Dg1uy5frmZIAF8LZbrHmTiTiipzwsc+CeKghs391zFBX+/tdsWiQ/pl5JIG8421xQBJ72D7RsZeYGm+etnG9zh6GGehP60FEmasYsyiWX8u30UrBAtAvKK0SQr5XD6vSVSHoVTItK+9eZS2X3VPklBt3No2BT8X4tObtqAm18FEQfPYnm3V1bnOtb4Nvsjmc0P3gptxIL9UwgMKR/gt/cEbrRdBMdRmAIQKJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(6486002)(6506007)(53546011)(86362001)(66946007)(478600001)(6512007)(66476007)(316002)(66556008)(41300700001)(38100700002)(44832011)(5660300002)(31686004)(6666004)(8936002)(8676002)(2616005)(26005)(2906002)(31696002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGd0Y085MWY3M1BEZkJ4N3lJdWVBd3Y2ZTkzYWZFaUtkYXBzdVFQTVhHODJN?=
 =?utf-8?B?RzByZG9yYk1MYnd5dGpMMC9ycFlhOSs5SmVpSUJURHRlSWg1TVNGM0FLQWdq?=
 =?utf-8?B?ZHU4UzhzeHM1Q3N4VHh0SW9CUHRzaDIzZFNUd3ZUSll2WGhFM2hRVlJ1dkFw?=
 =?utf-8?B?Q3B5Q3VrS3RTTHlIcW9YWlFRWkVZYnZPYnZTbS8wdkdHcEF1elU1MzlDMXBG?=
 =?utf-8?B?U2tha2tkMU1NMXlFTmhGb1BYQkxpU0JvLzhRbmVJSE5Bdjk3SG5vY055REdX?=
 =?utf-8?B?V2wvZnpoZ3pmcTZQcjVKQ3VaZXlvZjVKWTRScE9pVFVJQTd5Qkp3bzVZUnY3?=
 =?utf-8?B?eDUwVlN2RnlXTE5VNWsrRFJHRGRuc1dhU05XMUtOU3BYZHA0bTd4RmpUM1hm?=
 =?utf-8?B?NXQ5Y0Y1cWNYYThaRFJsdWdYclJETmdzK1hNM0cwTXl5d2cwa3lzeE05d3JG?=
 =?utf-8?B?c1A2YXFoZUFDU3JNcnZOV1RiSWhwTEh5U0ZZcDlLSkRLVld5TlkwcFpTQzZr?=
 =?utf-8?B?UEJESm9SQ0NHUllYRlRCa0U5cmxKY3RQSWtFV1RtKytoc1lKM1l0RHBHR2pZ?=
 =?utf-8?B?MmNzYmxDREdOZU9tYTBqVUxMc0thcEZzVVc0ZFNUd0J6aWhuM0NRTjNqTE5v?=
 =?utf-8?B?bmNnZ2FzRVVjV2N6Z1BBRlBxUG1McU8xb1JpQmJ3d29XdDVQdStFZkY2NzYr?=
 =?utf-8?B?MEV0WW1wZThySWRnaDhpOVJYNlRycU53WjBnNVpMZVNFdVJJVXNxcTNSdkor?=
 =?utf-8?B?dUNKbFhnS1JydThHOWRqNFpJaE9iVlN0ci9HNjFveFRvbmFxZW1yOHA3Sytu?=
 =?utf-8?B?UHo2U2JMbUZsL3c4RmNsemtSNEhrU0JZVExxaUJuanh1QTQ4SVlxS2dnMVJT?=
 =?utf-8?B?ZEZWUTFPNXBjSktaOVZrK25tc0p3NlZlaUtFMUhlbWtkdnBDb3A3aVdDN2tT?=
 =?utf-8?B?aGlUQXRnWkR2akNWNVVPeFF3ODBvY24rbnRUc3RxOURUMmtISS90d1Z1bFE0?=
 =?utf-8?B?d21lQVlaZE5KYmRYT2FwTTkvZzR1WlVZMDQ4ZDEzczNUSG5XQnJXRXlTcTlW?=
 =?utf-8?B?QUpkdVRJQlhVMEQ2THgzTjdVUXUyNjl2T0NEVlNOb2RLUUo2dnREaXBBSEI5?=
 =?utf-8?B?UytvTnZMM0VGOGE1bGFXd0ZOVU9vY1JvaEFIRDUrejZwbXQ2WmtwSXdUUDdj?=
 =?utf-8?B?WmdxakpUVU9nZ0JxR1pJd0N0UXZZd1pPR1l2aldrZDY0WU5mY1lRK2xRMWRQ?=
 =?utf-8?B?RlBRMVF5eVNWam53VGc2Yi9MVGZHbkE2NzE2SEw0YmdIQ2Y4eFVDaTNCQjZS?=
 =?utf-8?B?b1EydWtEVytzK2d2c1lYc3hPVGVVR0JValduUWdoMk5lRDlMZlBqcW0vbFJD?=
 =?utf-8?B?VHY1QUpzcHVBbGJyWi91QitHYTFQNXBGcXRZUkVkemdVUjdMRGl6VWNzMlor?=
 =?utf-8?B?VzJHa2MydE90SHdUNW4rZDlQdVRZUDR0MVJHdDV4aS9OeUcxVHhja0NnTEJG?=
 =?utf-8?B?OGRydVNON2hETWlRR1cySzd3aGRkZkt6YjdCQkRONnBIR3hPbTh0OEJKL3Vi?=
 =?utf-8?B?YmF0U2FtUFpJN3hYTVJNa1IwWlo5N3RHNmZSa2hyM3AreFRiRW9TazZWNFgy?=
 =?utf-8?B?aGV3enNZTTBzSk1IM01qTkIxYXdReC9pMEpmZUdtWHA0R3hlb1dEd2h6QVdR?=
 =?utf-8?B?RXd6bForNklFemcva2k2V2xRN3pHcWJaMlU2dXl0eGl6REF6aTA1QmhsN3Y1?=
 =?utf-8?B?eDdDUTF2OFNJZ3poZWo1T0tsV3RVUHdYUXB1SWdzSWtLdVE3QytUNVRNZDFU?=
 =?utf-8?B?UHRJcWc1R0syK2RLOUphOTFTYmgydVFsM1B0VklsV1BFVXBQSGloL0M1YklG?=
 =?utf-8?B?VXNtVFI4cTVLNlJmVU9DL1VXQUdsUjRITkF1V21OcENGa2xTUVRoN2NqUkR5?=
 =?utf-8?B?a2FFVkkyR1laZ1cxeHlZaS9IVTczWmo2TDU5NGxwUUxid2FxSmdYdlErOFJI?=
 =?utf-8?B?YjdDNXFncm4xSWt6ME4wMVh2RVh0L1lvcEVxRHdwQkFST2kySUNtcXNMV3Mx?=
 =?utf-8?B?cGwrTFUrU1pTSm5XV2tZazdwQXBobFNKWjdZVisraUM4ZVQ1aXZwTVN4ZUpM?=
 =?utf-8?B?cGlrU1NZeFlxcExYMFVaendlOHJESjlKTEkzL2NQUU13cnE1cWNxNjRLZUda?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SSa/F0UXi+TV4AwzEZZUUzx4tpU63Tg/JjNaEelRVY+psddFNZ01R04fUvxIW9y29Ng0FMGvktkjU0RK3YmeokVOzTwdAyVqNUdy0955URx0dCtlDz86pnuZxZgG4MBH9XoTRWxPCeHFm55hy4t33eFj09O9qiEcL8tkyjsCSbqNJNNGAAKILeP/z1chqyz2zkmW68pbmyFMNuvj/MkyOO0fIrHcNa54C53Wo+ESLz9oxfoTSZ9dudxUtRK8bMMHFIhmSCVo9jLt5MMc6jp3DeUYBvlyQiDP/YjVVwKYTmMyxGaW9Y0UcuJu6TuYZpyIe+mfxfxDjN4Vf3f+ZQpb+Y6ghqMXogvZqvNMQEjcXhOrewrG6WgQDpSEkuG9XI12P6YabPiLlu/ioZlZz1Drookx5B1t6lUOvOu85XAy85xWbJjmn2Mmmc4ry4jLlWfd8fmWKxfyp6HKNhAioQowYvxVvPh8DJ4VzhCl60B7DRmUcJkSmOHKyicTEvvuIjADEKfQxsD3D/DKleplCXWdj6aS0z+5LT/+c9QB+ORGvKVzfpEGJYHD7PA4kXeO3WQltF58A3o2IIISwdShzSjtirBqkH54viO49EWI4qtboNdBGsVaztQi5Iv7l0V488ns0wFQwJdbsMRlRpWDuKSJ36/EzKMQuIeCmnromur/5JxYUpwLI97UFq1TdQuM8MOHFRQ3zSh92TC/ukLf3kOI7XWOXFfP7KxNamuDFPykQK/qQRl78dhlqIYYxkr95mUEhL/BsmnP0fUFugMIQuyc4fn+E7KBexYJoQZV+g2Qbbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4333dc-5a9c-4838-8539-08dbba3a4ea4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:32:59.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qGILsv00WHciA6wxgjFebEhrjcCi7Y5Bsk7V13iAfksX/c8/GBqqBUUoiTd7nQlC9QUvuSAPb/HUgUWM480RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210003
X-Proofpoint-GUID: SmbvZgA0cAs1Y20jirkT0SkabowH3SnY
X-Proofpoint-ORIG-GUID: SmbvZgA0cAs1Y20jirkT0SkabowH3SnY
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/09/2023 15:51, Qu Wenruo wrote:
> For the incoming "btrfs tune" subcommand, we will have different
> features supported by that subcommand.
> 
> Instead of bloating the runtime and mkfs features, here we just export
> btrfs_feature, so each subcommand can have their own definition of
> supported features.
> 

Looks good.

> And since we're here, also add needed headers for future users of
> "fsfeatures.h".
> 
I don't see anything added, missed?

Thanks, Anand

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   common/fsfeatures.c | 53 ---------------------------------------------
>   common/fsfeatures.h | 50 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+), 53 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 9ee392d3a8a6..f8eeea7695c1 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -32,64 +32,11 @@
>   #include "common/sysfs-utils.h"
>   #include "common/messages.h"
>   
> -/*
> - * Insert a root item for temporary tree root
> - *
> - * Only used in make_btrfs_v2().
> - */
> -#define VERSION_TO_STRING3(name, a,b,c)				\
> -	.name ## _str = #a "." #b "." #c,			\
> -	.name ## _ver = KERNEL_VERSION(a,b,c)
> -#define VERSION_TO_STRING2(name, a,b)				\
> -	.name ## _str = #a "." #b,				\
> -	.name ## _ver = KERNEL_VERSION(a,b,0)
> -#define VERSION_NULL(name)					\
> -	.name ## _str = NULL,					\
> -	.name ## _ver = 0
> -
>   enum feature_source {
>   	FS_FEATURES,
>   	RUNTIME_FEATURES,
>   };
>   
> -/*
> - * Feature stability status and versions: compat <= safe <= default
> - */
> -struct btrfs_feature {
> -	const char *name;
> -
> -	/*
> -	 * At least one of the bit must be set in the following *_flag member.
> -	 *
> -	 * For features like list-all and quota which don't have any
> -	 * incompat/compat_ro bit set, it go to runtime_flag.
> -	 */
> -	u64 incompat_flag;
> -	u64 compat_ro_flag;
> -	u64 runtime_flag;
> -
> -	const char *sysfs_name;
> -	/*
> -	 * Compatibility with kernel of given version. Filesystem can be
> -	 * mounted.
> -	 */
> -	const char *compat_str;
> -	u32 compat_ver;
> -	/*
> -	 * Considered safe for use, but is not on by default, even if the
> -	 * kernel supports the feature.
> -	 */
> -	const char *safe_str;
> -	u32 safe_ver;
> -	/*
> -	 * Considered safe for use and will be turned on by default if
> -	 * supported by the running kernel.
> -	 */
> -	const char *default_str;
> -	u32 default_ver;
> -	const char *desc;
> -};
> -
>   static const struct btrfs_feature mkfs_features[] = {
>   	{
>   		.name		= "mixed-bg",
> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
> index c4ab704862cd..c9fb489d2d79 100644
> --- a/common/fsfeatures.h
> +++ b/common/fsfeatures.h
> @@ -19,7 +19,9 @@
>   
>   #include "kerncompat.h"
>   #include <stdio.h>
> +#include <linux/version.h>
>   #include "kernel-lib/sizes.h"
> +#include "kernel-shared/uapi/btrfs.h"
>   
>   #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
>   
> @@ -43,6 +45,54 @@ struct btrfs_mkfs_features {
>    */
>   #define BTRFS_FEATURE_STRING_BUF_SIZE		(160)
>   
> +#define VERSION_TO_STRING3(name, a,b,c)				\
> +	.name ## _str = #a "." #b "." #c,			\
> +	.name ## _ver = KERNEL_VERSION(a,b,c)
> +#define VERSION_TO_STRING2(name, a,b)				\
> +	.name ## _str = #a "." #b,				\
> +	.name ## _ver = KERNEL_VERSION(a,b,0)
> +#define VERSION_NULL(name)					\
> +	.name ## _str = NULL,					\
> +	.name ## _ver = 0
> +
> +/*
> + * Feature stability status and versions: compat <= safe <= default
> + */
> +struct btrfs_feature {
> +	const char *name;
> +
> +	/*
> +	 * At least one of the bit must be set in the following *_flag member.
> +	 *
> +	 * For features like list-all and quota which don't have any
> +	 * incompat/compat_ro bit set, it go to runtime_flag.
> +	 */
> +	u64 incompat_flag;
> +	u64 compat_ro_flag;
> +	u64 runtime_flag;
> +
> +	const char *sysfs_name;
> +	/*
> +	 * Compatibility with kernel of given version. Filesystem can be
> +	 * mounted.
> +	 */
> +	const char *compat_str;
> +	u32 compat_ver;
> +	/*
> +	 * Considered safe for use, but is not on by default, even if the
> +	 * kernel supports the feature.
> +	 */
> +	const char *safe_str;
> +	u32 safe_ver;
> +	/*
> +	 * Considered safe for use and will be turned on by default if
> +	 * supported by the running kernel.
> +	 */
> +	const char *default_str;
> +	u32 default_ver;
> +	const char *desc;
> +};
> +
>   static const struct btrfs_mkfs_features btrfs_mkfs_default_features = {
>   	.compat_ro_flags = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
>   			   BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,

