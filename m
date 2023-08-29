Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564A78C1C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 11:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjH2JyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjH2Jxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 05:53:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4922FE9;
        Tue, 29 Aug 2023 02:53:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6iRNC023247;
        Tue, 29 Aug 2023 09:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1ohhUHhNWBnGBIFfXYhC3DAg1aW0nZk4bCHecizKRW0=;
 b=pU/YuctL5rvnhng8ALyQBXicHrtfRjgaEsaorcD9WIbG1gT8QhrPS8yU2eS99PysUjOO
 HR19mgBY0tqETtd8QDAIsNVGSSdyES47IVjAlFIG3MYnXFIx92O7KtZ93Rx0bvDci9Py
 f+5yRjDB2FmmFOS97iXct74VFEaYLEYQ/iFmVioHiV8dXSlKzNxaCJrEF0ZhD4qdD8+Z
 gd/hZ3OBRt5ULZ2iOSZmP8pPanhh3UeIsme7o2XZ0YBMpzj3/nItqJzDyB2/eaNBfcyf
 FVkSdQDxshaT2Qb85ubxjXO4IpR2yJuBU/XQ3m51cUVotx0cDe5mfggK5DbR/27Lezdm sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk4mu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 09:53:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37T90ncB002464;
        Tue, 29 Aug 2023 09:53:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gave2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 09:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpbDFLGBSPjHJyFCiQqxfP4zuOFFAIV2cnnqN0AlidNzreB1Ubezm+G/2D/tLTPYJz5nnM/NcYDx7AEvz4bmolaSYg8tFDqpNIn6UR///7A4jWCubKy9FoAkLOD7+5vPc1KusXmsCngfZr+JwM9X7BKiC4qSsgSMKiGCmSTiq0PmRooCS5RN9XW6zCoQ7igDgE4F/KMA4a2Hx3gk/azOaWjpkoe+FqlQStl0zfa2JM9hdSL6zv8bsjqn9M0d/fm42iGnk43T9dMLNXul/xBHOdRUXB1fNMzatIaUmqcvyQbXUXiGrnq0FC24kjA/OxZ7Bsl/AsDnrz179bzDKHUXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ohhUHhNWBnGBIFfXYhC3DAg1aW0nZk4bCHecizKRW0=;
 b=AzBHqxf8qLcxa/uNx/StyVhRQUtnPS2ry1gjnhfUaaLL7hd3cfjJsJ1lVMgMkCuXOre/Bfh12xWiIGThM6hWpuAIwsCBGyJ69/9ncnCG+oXwreWMs3Z80u0AKQBQRq9wAozJG/0A/If/Qugkae8qjVgaMib9+7P4QHVGSgtk5aftcu0VOBzT/TvGvrhfToxi3tZkLuVGR8WrNM4Itcoq3HmoQwdsXsBLSyiAc017WSD0A2bwM8vGj2oFXU6FvIAagQmiWiKymKLNfcl8wAk8WdgS5tBwIRwAN8ublnhOG7JO4YSHDlaPMB6QsEDjIejlbhb0+634hoIzwOVBDyjaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ohhUHhNWBnGBIFfXYhC3DAg1aW0nZk4bCHecizKRW0=;
 b=uAefPSl+/eM7K7kMekyHdawjlqUWNC7t2Q2zHdKPsu9854BZV1XRzOmdqep/hW7kUXqSRmQR2GsZCODjSBPuGDnp3JuUgfTV6+vGfggkKOlI90pOEo5qecpmmNYnTPUIB2Axf5nFfZu3ERtFofcWAv/ksl3FTZqjiwk6mq086zw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7405.namprd10.prod.outlook.com (2603:10b6:8:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 29 Aug
 2023 09:53:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 09:53:36 +0000
Message-ID: <35cc63b4-a52b-dee6-5e51-489402c20ae0@oracle.com>
Date:   Tue, 29 Aug 2023 17:53:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@suse.com
References: <20230824234714.GA17900@frogsfrogsfrogs>
 <62240534-27e1-a40e-49a3-7198be83b8b3@oracle.com>
In-Reply-To: <62240534-27e1-a40e-49a3-7198be83b8b3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: fa897133-1511-459c-35cf-08dba875d079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgwvR/xhAe9HuE3aMGWVwdcrhWQFnzxzM3duf6DhrOsutX3iyzODsfQ488zbLPRVwVfiuWIU/r8frSn3fQd6w79H0AMMufZIEWQ1HhgR9EfeC8PNrF3nfDdIDbokmf36xXniGE/RTESfqZM/I2tbsycTwvURubXyY2InJXtPPYDtqNwgrmacwhBP/E8dWORFcNcvodsEgfJfdzIFDE+peACwRQnl+osQpouKZWYJToenq9mZjSi1zweCA0Y3wluitPwdFOr5bXof+hZ73rvNYJTPjsjlTNJjDgDi9zAafOemRLXXiodnByS9XP2965g88ZI2ts7UvcwCr8+5cvlrKLIrAk4j6gbTZPeo+eEoL2nf8EqDuX/Sg3uX5nMkzlqWuPXWYEPRXqClJXqVS4verN2AYBhwnWgELZmlfY6SvJljXQd2FMTet1TBwDs6H/7E0sPhe/iee9+j8E0Vmg5F2/c29VlrJORbMyE791JaWLDguhn+37ljK5a7OH0OuQfEyGV5c24krHYgufd33SCiV2tj5CjDr83j3IJ4gOePiz8vQSuBNCcMZ1yAcl4QKCUB4GGn2MRGr9wq/DAe6eL6+T8HmSzYAlpGxPJOy4XYqdsR7QyrC3NMPUPfrnwB0T3WCps5r1pZamaLwS7h9kyhKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(38100700002)(2906002)(4744005)(5660300002)(6486002)(44832011)(26005)(6506007)(31686004)(31696002)(86362001)(8676002)(4326008)(8936002)(2616005)(66946007)(110136005)(6512007)(66556008)(66476007)(316002)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1BUDdpZjVxbVpYYXUvekRuYUk5YTBwekR1R0xycnl5eFo0WlVYSGgxSUJM?=
 =?utf-8?B?cDN4ODZOaitQdHZvSmZMREZ5Myt5TUZDSDZrM01MVzR3bFFYNzlWWDl1RFRC?=
 =?utf-8?B?bC9PT1ZleCtEWUJ3Y3pnb0liWkpleDFlbXovMi9QUHJHTkJDQlRVTkYwQVhM?=
 =?utf-8?B?STBEWFBvQTZVYlJ3bVYvVGtGYi9Rb1BpWmllNDVZY1F3NytkODc0aGNSMFJq?=
 =?utf-8?B?Q3U2VUhjRXFCdkRlOXY0ek95Q1hqYjBRTnB0TVlGVXE5Uk9hbURURlVGQUlw?=
 =?utf-8?B?SW5DemRoUFNlbFNBamM3dE5RTlFQZlN3QkFOcXh0TEtCN3VDWFpTeGNqcFlN?=
 =?utf-8?B?TUVFTG43SVNGSVRZTy9RVUcrZmtsK0JqL0JMTlNtNHFxVHpQd1MrM1I5dFoz?=
 =?utf-8?B?Vk1lYlQ2dzVpaDhOYTlicTF0dE1vSUNJTXlrV2wrbWJueVJPREd3NE8rUTRP?=
 =?utf-8?B?cExCYUgwdTF2dXhSWXp0RjFlNFA0SWpuREx4TzRUaGNldnk0SlNWTjBuSlcx?=
 =?utf-8?B?RnMwa2VwVVlJa0VLZjZZMDNHNlphcmduVnFlOWllcHhKU3E3Tm1HRkQxQkI4?=
 =?utf-8?B?a0QvVW5QOWVUcTVoVFpEbDhvY3ZiSU1TU3haVUNSK3luRy9SYm9BRURJRzRt?=
 =?utf-8?B?aGRqenBKbmVtWG1mM1plVm1WMktqSStiZzhXRUs0cDJDcnBjZzI1K3FiWEli?=
 =?utf-8?B?clcraTBITHJrUUFJRWczUUZlNUFZZU1hcCs3Vno4V3YyUTFqZVQraWNCTnVl?=
 =?utf-8?B?cWxYS3NxVmtSL2YvOHozWEFMazNhdi90cGlvQmVudC81TWJQOHZLd3dLVXJZ?=
 =?utf-8?B?SEpHNnpZT2pxRVNUWmk5czFQMWlLbmV2ODlFTDVFNEphTEtpN1pIdWgvUVB1?=
 =?utf-8?B?TXBtTFpyM210SHNNL2RMalQyY3NhVnlvN0JNV0JqazRTdXMvTG1ZT2xmQUda?=
 =?utf-8?B?UzhpQWg3OW5tcUdtRXoyREhPSHNMdWdQckJUYXg3VGk0ZSs2dm1TcVE4Zi9Z?=
 =?utf-8?B?eWc4eS9EUTY0S1BhMlY5bVlqRmpUNitKc1JZaVFRdmhoY0JjMGsvT3NxTU5q?=
 =?utf-8?B?Z2EwUTkrRDMzbW85RXd6ZWlkWnF4Yk92OWZFVkZlbVVkQ055SFBQdlN4VkNY?=
 =?utf-8?B?c25VVDdpSCtPLzdkUDBFM1VDVjlTTjlDVmI3V3FPOXlYVno2M2htbktFSDYr?=
 =?utf-8?B?S2RSYWxvWFJJSU9odkNrMi9lVmN4VVFuOW1kdFp6VEJlMHFaZVc3TzdQZGdk?=
 =?utf-8?B?V2tJeTBJcU14UGY1cXFtQ214S29xVFlhOTM4aFZPR0dZSzhNczZYTmZ4aGVO?=
 =?utf-8?B?Q0tmWXB6Vnh0cWRhdlE2RWNweVJmKzBnTjcrNVVWZnF4S3cxaXRpaFRoRXlq?=
 =?utf-8?B?THExZGxNbXRRZVVHWDNuREFjeTh1alczUkg4aFhqa21xTVp2SXp4SlBEM1RQ?=
 =?utf-8?B?YkZpWDVXRlZGZExHRjcxQ2hEUnpHUW40ckF3ZEtibTFFUjVPYWxSOHRnZ2p4?=
 =?utf-8?B?YVIweXl0djVaMGNwb0FteWpxN25MVDlhQTdXMUFydGhZTG1tWGtQRXJzOGZx?=
 =?utf-8?B?SzBuM0VUdmh0OE5GN3dlK1dXakxURjJVdnhjdGpQRVp1NlF4dFJ3UWxPUzBp?=
 =?utf-8?B?MVRsdjBNTXJjTWV1WXZ3aGtmN3NUK3ZsTTIxZlNzL1Y4N3hBU2VXQkJJVmpY?=
 =?utf-8?B?OFpKcGY4MFZqdUY0Z1BLUXYrQ3Z4WWxNUHZSMDRta0hSL2QzaHM1V25FNlk0?=
 =?utf-8?B?ZHZHTElwQVZIajc5ZkhiNVR1UlBjM3NsaW1LbnVKbmlZTzZlMm11elNROGVK?=
 =?utf-8?B?NFgzdGZDYm1hQUNFYmVDaFpnOHBvaFh4Z0NDUkVqMy9UTFp1Q0Y0YXZPVUkv?=
 =?utf-8?B?MzJJMW9OTGY2cjFxT0V2d05vVktacmhKQUpuT2hpVzVkbGp5dzJoMFFzRjFr?=
 =?utf-8?B?NTlHUjlmWURzWi9PZG9MOFQ4MHRITUdwcjAxMDBSUDhDbjVoYmtEZWdlRWx2?=
 =?utf-8?B?QUE2NlZnajVCNUJsd2dKNVd3NHcvQitIMnZGWWxnSGNIcGI3RWFEUUtsa3Vr?=
 =?utf-8?B?blE0anZnc2xFUGthRXBCekVhVkpISExmYURkUi9CMmJ1MGZhTmNFNmlha3d3?=
 =?utf-8?Q?Bq4ZOhgCAiEknYXtWOtl51vaS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AKM27AQbVSAdQ4aCCQL7prDhKLr9D0Uj1/QMY1J+5vWYzUfJBJU2fzGR/Wbwq9RSTHLYbzh5UuOs9OjZ65sLSS1PIxT0v/iBSaKtnk6IS4LxckDFqKviWLRobqTTZO71Okfo9rpDdP3jTNp6pWJcbI3ufzNzVYRJtYYm6VdE0gcxXStBDrb2xpMFtgDggHqaNj1XmgGtZf+0VKl2RHsorkMhR2v+ZHUDBg51jyU5UMzlkZPPrPYf6BcdgENUh1ZDkQ/eWTFSAThPj1nEKNv2rp/usvJYebU1/TENAG12Qs95ec5QcxiGBQGkfnGNaoPcxZEFVXJpaFI5ZSMne7xmbcmzwbRzh5BhofC/nUpOTk9qA85VRVnHNYs8Kk2Xo1ZDFQsjN8uPsy7yN7Cmi7JDQL0GPl+DGuyb/oBoQNWHNsd1nK47BiuxR5Z9OLUVL0pYqYjhK0mHIVotjtt0Dldfw317EyPK+7WnRUj+jQX6TV0/mQPG//WQ5vOa809DpjjgSGFm3mIeA8B4I7rS91605RIGWTCwRoO6kDFEpv690dUVqYmkurc2Mlh+0PwjXrVaqaTnC0ccLcNIY1KGAQ9e2bZ2SWVYDTdn13b6Ue32elBZIMBtbFgZUxCDlAT391k/W6sXqwijlyAsfs+ADLHF+qgMJPsNNGTbejOAc0mJdCkbdajiIURbn4c2d3qf8eIQC8szBXd3XgeRTiNXk+HY4EQGJC9hBaFY+e5SCJywPhkYHfCqhW8NxnwYEsgEtdd9j7aZuOvVS8tRKwE51lHjlp7jCJeXYrFx31OiHNUMV86tna7jTIkQHAq4gdKMTllgLYWvNpy3T7vCaJv2QSyDww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa897133-1511-459c-35cf-08dba875d079
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 09:53:36.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQyMC8BesoC0ak7cG4xXtDBGxR/IcLyEOEQfr0fwGqVhty280Y5VBgqEKRH1BFAx2u/3GzbCX5dMtbZ3MyqgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290085
X-Proofpoint-GUID: Eeu7ilmx4WKo02YgbGPyTRNeGitbxwOW
X-Proofpoint-ORIG-GUID: Eeu7ilmx4WKo02YgbGPyTRNeGitbxwOW
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>   _require_scratch_size $(( 5 * 1024 * 1024))
>> +# Make sure we can create scrub progress data file
>> +if [ -e /var/lib/btrfs ]; then
>> +    test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
>> +else
>> +    test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
>> +fi
>> +
> 
> We need to enhance this to  a common helper, as there are many test
> cases with the scrub command in them. I'll enhance it.

Hmm. No, for all the remaining test cases that use btrfs scrub start,
the output and its stderr are redirected to seqres.full. So, those test
cases will still pass. And, btrfs/282"is the only test case that
requires scrub status.

Thanks, Anand

> 
> However, for now, this patch is fine has been applied locally with
> commit log changes.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
>>   _scratch_mkfs >> $seqres.full 2>&1
>>   _scratch_mount
> 

