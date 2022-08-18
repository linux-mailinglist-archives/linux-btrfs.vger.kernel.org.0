Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4EB597C58
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 05:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbiHRDmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHRDmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 23:42:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0351692F43
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 20:42:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I3PTGR014269;
        Thu, 18 Aug 2022 03:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E9v+r7Bbcsh8DurX8EEiSm4ckF3us/llhXpzW9i4a2g=;
 b=oNOmXq3rBLu5hpJxmfSJuG1L+7JKMSTqccRUzI/NeQwj0Zj4hwbRFNGxCBXGSShAj3rV
 qzT4TJUvbk+Qo+IcO7TEmiN2FDfX31Gl6++hE8tK6gXd/7zTNpzheodMXfWfmqVTUnCm
 w4/BB516m0Bh7gyjL2puSCaOXVQh2FeQGJjeGHpVkwUi8hO9zebTVqWfD8FD7WmRWbvJ
 uiv/5ucykrpE1itKc5nQTcojKbst+nQu11JqJ2FXDxEJQXkfpxG1P+hAgto+L/o6zsYM
 lj+Vv5CkeyPGpeC8/FEVOZrzVuW59Z3noBWIjEsSj2NOx1YPyTXE7gzX+VC3zVnQ/aX5 iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1dgg00rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 03:42:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27I1d3LX032789;
        Thu, 18 Aug 2022 03:42:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d44040-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 03:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U46C9QqGeFbldTDq0C7pQqxyn3DU3YPocY9s3PnMNxrTEVjllSdsdkUcPIuo/gw96zCqg+PvSIz4FsWnAvy3pNvqUTgWvYekzL9fpwgwC3RRaTTKFE5NsGenGv6y4uEZyOPsn5RfCvJaO3WK6FNftznoEiTeK6RhTkU+D1NZA5roJgbKzlXkIXy8mdY1VfjDkkoo71nDUx0iigv5miIs30xzD4nMNGT29hKa2O4kspVQEXIBPeY2EFjEV2y0Nx3wxvZorUtSpCdRgogZacoA0mVDXDEE64n7VRHeGvkRziINOdijWTuGS1nPBbLmmDfnlFbeCG7WSmrLdfRDIy8Wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9v+r7Bbcsh8DurX8EEiSm4ckF3us/llhXpzW9i4a2g=;
 b=I9N/U2KTi2oBT0kmkCYF4wIyP+V4kK15oyPDLd3KgRW275jbMQVepokO72N53FX5LCsuyET5AhZRDyvftsXrr2gA+8jFDYNfKfxK5kUzYiRGKe9vI4j/8HvJAxKf3GDC/DGaOlljo+sv/0r+41lLdSj/oxROMVWSEak0QKNrmdj5mJdXYzpIsqcWQsSoqfd7z9umxs/znIOnF5v2NLo6DcCxQ3M9lfagAZ8KfBkVOPEl42Gms4TeBXedGPtTG5FdJ5b3dkR0U6+WQBKaOX+FtSpIyfiRITavzNjUExsG5697x1vpcj+MsVECZfA7TaBl0aPaJ+8c+s4VkFVkdSgLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9v+r7Bbcsh8DurX8EEiSm4ckF3us/llhXpzW9i4a2g=;
 b=UQQHmKfQ9qb1bw5KLQpH7HmixTro1km3468n+Ak10eZzah/JeFa9HgLZwO019QAJtvMkaKCLQz9TSxcPF+gAlMfCY2ukTl58DFIH28+yks3C/MlHq1h41SMyzhaUuABQTDDjzkUq4rBifVVx8+Yh0IJUZ6pSk2fwuCZNXJoIV6g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1657.namprd10.prod.outlook.com (2603:10b6:4:5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Thu, 18 Aug 2022 03:42:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 03:42:35 +0000
Message-ID: <3d566dd4-8239-a39c-01ab-45c1e9300a1b@oracle.com>
Date:   Thu, 18 Aug 2022 11:42:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: Check if root is readonly while setting
 security xattr
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     fdmanana@kernel.org
References: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a65760-b775-4511-2a18-08da80cbb012
X-MS-TrafficTypeDiagnostic: DM5PR10MB1657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJZYWjKnvUOXlDK8fE7N4Ta0zX7HSL80HZjKuoh40Jsnz4FV0MLOl+1bYrH/bRR2vOJ6o0Yqx9ITYPB+q5Vm+GNB5a+HhNlIY6mUagSD8t9CrZUO/Ip6JbRcPfkas1uTGHaUcpa+TuqxKPVaTvlPTUk+7+nhL04pn8Tp20yOthSNBEYfKNLeWAsNpDcg8xPpDnK92GGVLGhtrvfCVcGhQy5ccOEVw4X4oUEFTAlVi40a4ihWE73dS4C1hh+PRP6VxKCTr3tWKD0JtuyXzQ0XhN9+UMo+TdBlpTzQf5DPOOVMzPxlEmjRmUA6mo4Xb8G5zKU2Ssb3MoSglC9IEA9Zs7mJIS+pNPQIFix5CjSRhd0LQSY1yrrFgLkEByEITsDbgEQiSUzu4l4xO7PvGA0+1YtwZHlpuHvOUl6foQiOWm4F+du9p9H1Tys3DvTskbmUHUwSnZKhUQvxo343hj/hho3mMH2lM2r9Lzk4hOBim575FeIucTjJ5TWGwM+1OPBX+7hxSUOL71tQeNLfsSpUMf7dW5qHcWo0AMJuBAN4nMoz2MfejlENj1ueaHR6JvTXvv7afTy9crnsTn0RUI3MWGHAopAUxI4E3bw4qBCB8/h9QiC3B+t8Vk5ZoPjaGFbVGy8iRXMNOB1tavmnkANPrqQlQzMr2T0k4EIeGdQ4bXYbPcx13C8KCjH5477hkCcYdslplZN8AQki6BJ2DRcUXuxIcLBywdmV2fy6+1UsmovVcNpKYuir16+hvvy89+9Ag7gmQQBJElQ9bdrr9UT6BwWXMpzNaaDIRuXlnjX4y6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(376002)(366004)(86362001)(66476007)(31686004)(31696002)(83380400001)(186003)(2616005)(44832011)(66946007)(8936002)(316002)(478600001)(5660300002)(2906002)(6486002)(26005)(6666004)(15650500001)(6506007)(6512007)(53546011)(66556008)(41300700001)(4326008)(38100700002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJqYjc1UjdhQTRiMkpsWU82NDdmajBkWU9BRGJtWGE4bGJJUTYreC80cisv?=
 =?utf-8?B?cHg0enBVQUpyREpZdytobmFEOTBsR3o0UTIwbmFHVDF0OVdIa3Y5c1VjUTVm?=
 =?utf-8?B?c1ZiWU1OTWFyMzRJRnc5bzZWN1dDMmowZVpGVWh1TVRDZkE5TURMeUorbnNF?=
 =?utf-8?B?NklpZUpjYm90WS81bFdpd3o4VGpUT1liMUJ5QTZ1RFA2WGcvMlR6b1VmTmpM?=
 =?utf-8?B?Zy9HTUs0Vk5nVDFqeitzZ0ZtTlljSklvZmJBZVRwbGQxam4vZFlQeVRNT200?=
 =?utf-8?B?Y0VWajl5bnJTa3dvVzE1NlZxRm9vRXN4UG1DMzlTbTI1c2hsZlVqQ3dHQVFV?=
 =?utf-8?B?M2k0Qk9ob0xETFl2MVlnV09nbldvYVE3aFoxRFpsdWJXQUJ5TloxQTBCaEJs?=
 =?utf-8?B?SDFobzZiYmY1eWNHMHI2SS9yTVVqNzFmRXo0NlNWV0NoRFVlNGFkbUVlMjJx?=
 =?utf-8?B?TVpJSmpQdnVXT0NydStaVG1oUnFKLzZmekFHL0ZHV2htcGxPYzVJV1lBNjdp?=
 =?utf-8?B?TUxsUXVmYlRLUmFYQUV1bTBMUmlBdHdSQjJzakZMUW9CVHRLMi9odExSNyt5?=
 =?utf-8?B?eDdoTVNaWU1zL3dsdjVYbXU1MkZSZEVZQnJoTTFxR3FEUHUvcjVIOXpZbkV1?=
 =?utf-8?B?WXhtekRMWVdRQU5Ka3lvVHZaTmltS2M4VVh5TnRTUlpTTW1xSzFYWjBIeHJo?=
 =?utf-8?B?M05OcEwvZHp3RkRWYURWYmdEcktWWUhWLzc1UTZuL2RUdmE2ZDcvOHBSbTZQ?=
 =?utf-8?B?bUxvUEV1QXl3QUtsMmtEQTVnanRYUFZIeXk2SU1HSEcxb3RhK0l6VjJCVUVQ?=
 =?utf-8?B?QkpwWjV0WThVenh0YzlGazdGSVh1OEtvMU1EdkVhUG1qbkd5bVk0RVNITTBl?=
 =?utf-8?B?aHRxdXhId2RaYUdRSEdaZldRampGTkRJemFETHJ6V0ovSjAyMnVSeXpmUTNq?=
 =?utf-8?B?dWthaU5GKzM5OXBFeTZpcUFDUW04OGZxdW1IdWRObnF2ODVpVnNyUjJiN2Yz?=
 =?utf-8?B?Z0VRcDY4YUdYYkM3Q2tyeVZJNFdycUhsbWR2SFhiZmhMYXZrZFdTNklEU2Vo?=
 =?utf-8?B?QzNBWlJ1Z2RBZllJRjhHUjJSb3RwNWdiLzJwYW5pNGpOdXJvbVFzV3dKaVRC?=
 =?utf-8?B?eDFYQjBDajM4dkR0UXdrTnEvRmZLdzFmeUdqbE5pblZ0YVlPemswYkUzby9k?=
 =?utf-8?B?SW5OZEtjUU0wejVlQTFSeXZYYzdqQ3RGTDNQZzA2UUFNVU9FcnZzL2NYQnIz?=
 =?utf-8?B?cXd3RmhFMXZQTWZFaHNxamNYVnJyMUFDRllTS05ndDZQcERSVW4rNWJ4OFhH?=
 =?utf-8?B?UDJlT2JqMmhLRTFPS1U4ZUFnOVBTaGlnVUF0Q2YxazVvSXNKOUhNTUdtY2p5?=
 =?utf-8?B?eUFqNklUcDhQS0tlekkvZ0NtN0dhczlGeExzZjFObTFvYy94eVFnYVlhMldp?=
 =?utf-8?B?SXRlUFVWUFRKSWdQbURqRkJsdGtySXkvTlNzT1BCcU9QL2xSeGwxQVdSZ2FD?=
 =?utf-8?B?Q1VERnp3TUwvRzRPWjk3cjBFZmovK3E3NnhQeDQwa0NOTzRBRStkclhBMjhy?=
 =?utf-8?B?WkNNWmhqRUM1TWVicHJyWE5qcWZET3RYeVBBcWx3YWFyc1N4MzFRU1VFTlVC?=
 =?utf-8?B?ajJDaGUvbi9TSzNSeitDUWwrQzhXcU1GTFBZRTdCakdRejB0QTM1akhCNmlp?=
 =?utf-8?B?NEVHaFFuYzRKTnNaUmY2NG51dzNXa2pkZGVGYXgrMFNKMElxeXk0aVM0VmdB?=
 =?utf-8?B?UDBxN3d0bTMxaW0yUmh0WmFjb0pmWDhEODg1M3Z0MUJYaHF4WXZleU1Ba3p3?=
 =?utf-8?B?bzZId01kZ2VjVEsyQTViVytKemlVSkZXRXZ1aTBrT2ZyU1lZQlNVRmdNZ2ZV?=
 =?utf-8?B?KzZ1WlR6dm9rb3lMZ2JZTXBCbWphdUwwdWNJVzFlbXRyb2VLRFBqc28vZEZ0?=
 =?utf-8?B?d3h1U1ZZaWxOVWFYVkJ6N00rSXU5ci9LTkdXSUVNeEFORGU0VDQzb3JVdjhk?=
 =?utf-8?B?VVpacTBJbXo2dlZCd1BLanROeWo0N1NxRDhpR3poQ0MzN1lMSERheXZ4SlBW?=
 =?utf-8?B?RitpUzFLYjhLbEg0NmZzTFZoNWovSFJyMFFHczdzU1RjbVIxaEJlRmxROWNX?=
 =?utf-8?Q?4a2RONl7UH/xpg2WaDIsJ7Axt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uIJAawUJmhsM+a8OeWOk44e+9V7/uTha40VWvVEMDzEMt2AAgdx0fiWgjjjNaGvG26ZFc7zqyQ2HuQR6zWeiA22zZ2RCXH4wK9WctpOiyQkjRG+wrHGMiG9mEW5Y608lDG22EfBuYcfc4gDn5aQbaKAo0SFsRUeRFaxLWpi1wBhs+ixOHoZ9roAjAFohk/LhUslRWUK+6Vt5wADj9WWpN6WopHHryNI2fzBAFWnZs7/xFz3a6I3GfBvdBnPj35UFzrhl4yNmvXa6KHAo+uiLZDTEBkiDnzf4pnCKTQGsi2u/sSwa1ja7j+Ef8/pZgzuQJzkknJIoD4Pq3hokar037sOokFB8CT7+CAtiI6DHGUtBK2KmQnyRv12KJY+OPm0PGtfnFWRFZDcoLlWGwgPr7/Zl1CrOPBHUyyucnZtwBb1TzkjNRNHp3DX7YL+dvqYv82Mp3HHtEkLKsIbKAlnLtb/ZhhVyfFFYGkCnUTSifAsIjnd606df9hNbty+8MmxFdOEpNX1dvKWAx6MB3DT8DUGH3YUuF9XR68gqK1SYX+NW2gAAelzdAQAO49BWzf5TkSsj0gCNKxx+f9+SV/PUVrWyvRbF+NzktKnIWAw22c+MFQ45UjgWaSwvKZS7TYFWpfnC8UM8nXDgrH3qQONIKwhN4JTKqO0aPpLICx1mYEm4GIQMnwUwsTH43BpeZnrdznUrAC/hz9dAgmM4sfgYhAjQYedaRzOtj8kEU308jDTDNwbubXi1Fx6iYWCn7o+D+BVTa1Ck1Q1cm6Mm8er2YyS+bOStsq/UXaPZ0guGgJNPZjsvi1ia3PpJio+WBSc2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a65760-b775-4511-2a18-08da80cbb012
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 03:42:34.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 128/WcRGdKzxmmW+RuRXmC4bBcIYCc+H5YKKl6XAGDNnYVk48gCFIj81+39MAyWwtW/06lI87i5eeXD5LF5WZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180012
X-Proofpoint-GUID: VwNyvHTgTewK35KoxX4CXTMmWBE__e8B
X-Proofpoint-ORIG-GUID: VwNyvHTgTewK35KoxX4CXTMmWBE__e8B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/17/22 05:42, Goldwyn Rodrigues wrote:
> For a filesystem which has btrfs read-only property set to true, all
> write operations including xattr should be denied. However, security
> xattr can still be changed even if btrfs ro property is true.
> 
> This happens because xattr_permission() does not have any restrictions
> on security.*, system.*  and in some cases trusted.* from VFS and
> the decision is left to the underlying filesystem. See comments in
> xattr_permission() for more details.
> 

> This patch checks if the root is read-only before performing the set
> xattr operation.
> 

Now we match to the mount -o ro behaviour.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> Testcase:
> 
> #!/bin/bash
> 
> DEV=/dev/vdb
> MNT=/mnt
> 
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> echo "file one" > $MNT/f1
> 
> setfattr -n "security.one" -v 2 $MNT/f1
> btrfs property set /mnt ro true
> 
> # Following statement should fail
> setfattr -n "security.one" -v 1 $MNT/f1
> 
> umount $MNT
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> 
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 7421abcf325a..5bb8d8c86311 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
>   				   const char *name, const void *buffer,
>   				   size_t size, int flags)
>   {
> +	if (btrfs_root_readonly(BTRFS_I(inode)->root))
> +		return -EROFS;
> +
>   	name = xattr_full_name(handler, name);
>   	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
>   }
> 



