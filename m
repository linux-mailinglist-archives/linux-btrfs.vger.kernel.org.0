Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687E67C386
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 04:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAZDc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 22:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAZDcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 22:32:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769B81449E;
        Wed, 25 Jan 2023 19:32:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PM3vLZ020429;
        Thu, 26 Jan 2023 03:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=CRh99gG/u5qWnhxInL8UBRo8xtKAVzKMp7ppVy2+rCmXjC4fSeRjuDNFXHyytGWF5ts9
 qtlUTJP4QIfL9q1510TQxSgUCpctnroAAPWOaVaEMQ5sWAp1hK3NChTc1zvPw+gUwdv7
 aqf/YmVPZcF4qOaRwID8/Up64ygOe3sGWVHf/Jz6Fz72GiTdvzjLmO1E6H8Bbpx/OmJx
 893/5GEcuNPXi1uKRAEANmyCc2W01l+i83fh57LxabgvyZPj8a7tozJa4BfN0N0Wcqfs
 MRXmRUvZlfEaPj2pXFn+Xl6X2a/fYRoW1DKyw9kexldPRzBB9D1hG2n1dR0VPQjG/ZeW zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fchmgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 03:32:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30Q2h6Mj009184;
        Thu, 26 Jan 2023 03:32:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7sevx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 03:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXZt4iBNncnlzywCa/LLcSCUAxND4t9WKGcnQRNsJ+LQpus1RywMQ3iJj20uhKM2KAv7xD37ropHPDVYDWFK8n2f8RwPtwG9GVfPPnJn56QOZFOxMpc86SER4TCUJaamVwVpvMLFsQ36L2rU05E/5zgUKgVuP60bKXrOoObrREVOwFNbsFqgFWBFNjqztceOjRKRni6lK5PuUol7/PLzT5bvkDTxk+ACyai75Bhi/THWs6TuD85PJZJJAnDsL1wvcd+tfVg9peMAgWi98ytm+wwdsxQe4+vTl5hQQVnOv+wxpW8knB+EUWDLCnoZnuLVzwTmv/fIueu5ZYV4XwSzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=m9EBcCmc1v66LiXzWoWsS5FDlndiYcz2AQJESsjfO6JHmCvll4C+HE/zqYGCdg6Jm5krPiPeROZZHBccvQm+xLSCzZQx6X32o3NaY+31pYxpUkixeGRHGkLoGVwdCEiJKiPES2Oz+wjMxzcJJi3u9hnrjMI+a+90L/Mi1URUyKOZ/NiyG8JDwesu+GA+9vTzTbcGPg4bINoRfO311oiMiDAuyziaPenI8pJB45588D9LkOBcAKZoLpYT+tXDoTsW1xVWgVQ6DAtoMdmisB/4oGd6xvSpSJps03PNHwqjqAUY7oDEdCvwtch3AQ1EdvBVRTWbpmdV4B7/9XF8+dVYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=b1AIPeqPMkzEOe+ViHnRxvIul3b8qK6GMqYrLhyysiVIaHHU+oYkz880fz/O5Q4mu6CCvGURvvTjTuG9f09xoPA41Uz0M9sgYUbNIbjHOENEfyg33nM41W4ckRdgVOuQjfZS7y0c2fCeY/yVvNOsNIMD06iKeFNuG4I5JxfITlw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6907.namprd10.prod.outlook.com (2603:10b6:930:86::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Thu, 26 Jan
 2023 03:32:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Thu, 26 Jan 2023
 03:32:45 +0000
Message-ID: <d57179c3-8286-90d8-a8e2-e26af249f8ef@oracle.com>
Date:   Thu, 26 Jan 2023 11:32:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs/299: update kernel commit hash and subject
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <3ccaa4e5f43538891d312ba7e9e4b38d61434d35.1674644818.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3ccaa4e5f43538891d312ba7e9e4b38d61434d35.1674644818.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: f69b2540-ca6c-4f02-35cc-08daff4dfd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFYafTJCkRHOvvssm0wVs8Y2A3cKY/R2OcQMiDAi5maZwiPFBP8Z83Qk2mj38eWl+VCF9iFRTthQOBLgGPba9+2ESc8WfTnn+Ql+y9pXk6g99C5qAsvHHSJT+gbuqGixPBgKG+cM6bgO4ao5idvOBMKV46U8GFZmPV7eMXXc0DPS2yamJRBTx185x0mpuEiWQX4QOyjqyYhU+yN+3Ak06oLI+KhzQqMX45Kb+6IkQEJy64ORduu05IPMB13gIhtO8YfQdSDjjpEInr0lBD/zT+9v751ejQ4yEcQHPjYf3BlFjn7R5lz0REA2+lDFIviZuPoZ6loxejbrdEKhLtp+Zqiy8K9Xi64QXzRKtm8ZDUqRe+MkGiMRzmG97QnkfttLuskMEUjcowEv+lFUDetECzz2MpgqbVXNRpDpLoH1IUOGkp2zUIKd8a5DAu902SKSh4B2DKp6pzYl/6pcsfpUEeE/9Vr5EuDIpZTiqN9O87Aq7RB6vIRpUrxdRHKfmophNeFgAzg7nyIfC2eVBRb+sgkeR1lh2aJR7G4YuurvkCQtlIBRj0vL/1V9BG758kgBfQFTixBjX36/CdY3MCFPhK4uyeHrt90J63tU8rD5zvjCR34oNvl/MQzoigfS81MFXFD1aj6SG/K9Ouk/pjJnrjxhuvxpH7UQ5l+ItS/ysg/2f2Ht3sWXhL+tQjgkObRk9XUeUYOFbclohE/p3K6tfM4fmYF2wroDDlDIv4jD7rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(6666004)(6486002)(558084003)(5660300002)(478600001)(8936002)(41300700001)(36756003)(44832011)(38100700002)(186003)(6506007)(6512007)(26005)(2616005)(19618925003)(4270600006)(86362001)(31696002)(31686004)(66946007)(8676002)(66476007)(66556008)(4326008)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpOODBTaFh4N2kxbkpNelhZUEVXTVNsbG5pRGNMVWw5VjRVbVhtdElXb0ZV?=
 =?utf-8?B?NFd5ZWxNRFAvZDFHbXQwWUJZVVdnVlI1eVkxdHpEeDZWWHBmOXhqdkpFalQ3?=
 =?utf-8?B?SUFYQmdnOVB1RWtrRktJNEtjemcrYndteEpWbFlsdzlrSGttZHdPenJ2SWds?=
 =?utf-8?B?eDZFaUZqdHA0VVdvTzEvY2RNK3p5aDR6dExHZHdtaUUwZFplMmFuTXRKMXNh?=
 =?utf-8?B?UUF5NlZQWkNoL25jSWc5VDFzdzJpcDJqbGNmQU81OStJRHMxYkpUdzVIc1Ju?=
 =?utf-8?B?cExoWmVUU1NFRlRSZ3RxZCtqTzhHZXZxTmQwWk5OSThBaWRwV2dnVlNvUFFa?=
 =?utf-8?B?TlUvRGI3SzlnSjNNb2RudFRFb2YxSHFpNEVtbGJPNy96UU5MZVhuYXNpREtZ?=
 =?utf-8?B?aDZSemIvTURnWGROcWFhWW5FdGNxRE0vVnVTaStZankwcXhkVkgxbW5Zd3dk?=
 =?utf-8?B?OEJCL3VTL0hGT3VnWUppSHhrd3dERGNHUXRQeWdoOVhFWmdhbDZ0NlNQV2F0?=
 =?utf-8?B?RndzdHpReGZJMWFLNEZhVk95Z2srMGd6R25qRXd5TS9KbUxURmIvZHUxdTkv?=
 =?utf-8?B?UlVUckFMYkI0ZVhlVllOakIySkpHUlA5eFVVSXQreUpXS2VGQTAvM2pHRW9X?=
 =?utf-8?B?eWZ4TDJsTm9mM3hLc1ArT1J4cFJDOWxPODF2SDdncWtsaTRBZ1FyU1ZuZHQ3?=
 =?utf-8?B?NEJIMlFScW1lcitzYkR0UHdjUUhpV1VUUmIxN0ovcDJrRlZzNzc5eStTeDh4?=
 =?utf-8?B?d3Y4RjROUk5HVERvQ1EvTmpmVStjRXZXVEREUTNrcVRiZUp5OHF1V1VOTmFh?=
 =?utf-8?B?R2FuYzMxYy81ZWRweDlxdGNaQmdXTUR0VUFsa3M2c3RaS3V3YVJIWmZoQXJp?=
 =?utf-8?B?VVJyazVHVTRrTUFCRFAxYkNtYjhqZW9CZVg5N2RPUW9ZZEZnazFlbU1oR2dv?=
 =?utf-8?B?bWpqS0ltUDlRZU1mMlZqT0E1SXJ5MlVhWHhSOTRqR2VHOUJaWjBWUklvZGJ4?=
 =?utf-8?B?UTJBR2pZUmFmM3hLWkhveFVkbmUyZWYwTjBjY0ViTUtNbmpOMHhORmNLWC9O?=
 =?utf-8?B?UzFtN0cvbHA5d2ZtQTlQSmcrM0l1MGVtaWVVRTNYbHdhYTBjbDBnNitWcWNV?=
 =?utf-8?B?TTgrc29QQmFLVG9SRU0vRU1hUTVrNEtOT1BIbVcvOHdPenRCNW9HNkJZQzZv?=
 =?utf-8?B?YXdaSHl5UWthNlloR2lkaUVmYXJBSHRrd3BvR1dXMTRmS1RyWjJ0VUx5bllO?=
 =?utf-8?B?QktIZVlJR0pac1MzajN4MkM5UHlqaTBYU2t2K2hNSnM3L2I1bzNUOEVraWZv?=
 =?utf-8?B?aHZvNlJqTUpUOW9kMGpKN00wRU9UMkFVOWFrczdSaGh1cDNQZGxNWEdRWXFL?=
 =?utf-8?B?cjRIMkloVlhvbHB0UStjblRWc0w0cTV4eFpSVE5oeDYyQUZqN3ppNTM1MHdC?=
 =?utf-8?B?MFJvRmxKaWM0Wm93Nm5mKzIzdGlRamF0MnlMS1IxenBCWmRwd2ZyUDQzMlc5?=
 =?utf-8?B?SVdOQkROb3d6UEk1ckczL2JPaXFSUFFWT2lHV3NtdEYxdkFqb284UDNUYyt2?=
 =?utf-8?B?eC9Hb1RBL3hjbFp4Ym9jVW1SdTJ3cWpxOUlXMkQxNHpLWUtlWTRCWTltcG9u?=
 =?utf-8?B?K2Vva0x0Y09uTERWT2t4cEt6STFkdWxXaUFKaTJVOE1RS3VCdFlOazNNOXF0?=
 =?utf-8?B?MksvN2JsVjVDREltdmo1QkJkOTZCQ01hTmhLejVVVzdHOVNmVkNDWWx4QXd2?=
 =?utf-8?B?b0Z5aFJ2VEdWR3YxVHR4VTN4UGZ3OXVrSW1TQnY5Mkxabk1UcmhGZkNseDE1?=
 =?utf-8?B?bXpXaEFIeFhvQW9ybEp0bU91UXB2aCs3Q0VMSkhrMVp0SkhRS05FUFE5R1pD?=
 =?utf-8?B?UlhiSFdJazJ2Wi9MalhaYy9zMnU1VmZoNDZPKzFDcnJWdkpycTZMVTkrSkN4?=
 =?utf-8?B?MTdobElLbjJDNkUxU1R1TkoxUVIzWndGN2hTbG5UVTdPbXNyRktqTjV4K3NH?=
 =?utf-8?B?dFlFWFR3elZvV1k0OWlWSnF2MmhKWW1JRVh5L2k0S0h1dndHWWk3OTlpNSs1?=
 =?utf-8?B?L1diNWFKRDZXYzd1a3RSWjhnYnBvZlNvYzFhU0FFeURFTFMzV3hTR21NRkFH?=
 =?utf-8?B?RTUzakJqd080clFhQTRXREhrWG00WTVyNUgveGpXVkxmbVkvVzEvMjEvTE8z?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ibICepKlcqpbx+XHmrQl1IqxOxGuf9bQazbWXmU2+dMwyl1T0JjBmCs1DBOoujUP2KW3Ko8Lbcyfim79ouWNUae7oOPqGq1GPWq3z0L9xJT3KGmP+Wtz5MHWm93QZK1Na+6vXD2h6a1Ry3tK4AfQRMcrrv3ZyHzgozHraWzcl4zPyPPanzLADcdNTSN4hGz9W+2MrGQS6CTEQ2vcRE3rT03+z5gs7u22Wet5WEjpDOq4EMO8ZibknBm0ISs8XJorjyIgQcZMwX41CI0YYNc+UuaULdnBn3KnzFneur1m0ZUIM3Q9iYVidoLEoMDbdq3+oR4pCEjDK4cZ+J4J/oV+t615PKcSBUR1MJ8h7YZ3ygS9Yja5Zijp2uylwbMWGNmxPJJkyAe1GrK31myuRYwyzcFnlAW12qZpHFjeslAzJKYZ9Em/V8zXVFtYdclsS1G+yZfQ0yc9CGXYVkoWV1grE9uFtgpz53ajeZdL4pJYIGVeZJb+YgsS7R9HR72V8VszMr65aUlAL6hMGn+5bLYqV/WWFiWWBgZSGgCBbVy55Ej6mFp4ibyWjLXZkUHO32rnk7q3rC/65TxUavXLhixlEJpEHvlOjiTXng/ikQqI3ZdscF9JOk5Y+pzlwK1aqzSO2+NvYmTynFn/MxMuV1XfISFixojx73E8xzIEHTSXY2I4qz2YFrNuiUJg6Yg2gFSIPoj1buM43gBf75mrB3EbS1ZtNb6Ssn61wTkGK6PwuV4wlB3s8lI1UEOUFJNIkBkVQJSS4GIWRlnLASRKR9sOEoPaznp73/Qd9AyKnoiwoY52Lt8U81dJc7wvXIZY0QNL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69b2540-ca6c-4f02-35cc-08daff4dfd13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 03:32:45.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdz2vfC+5hVBjriOn9+lsM4ZTDuMcbbyRs14WLByoH9f4jabnQ/s8x0NIJ8BGvIuqTgfUKIfXDvLnP16cq87pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_14,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260030
X-Proofpoint-GUID: pPRPMpaCtXiCV6m1XWanawvHsoO41df_
X-Proofpoint-ORIG-GUID: pPRPMpaCtXiCV6m1XWanawvHsoO41df_
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
