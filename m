Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6986897DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBCLit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Feb 2023 06:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBCLir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Feb 2023 06:38:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09863991F1;
        Fri,  3 Feb 2023 03:38:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3130O0LM008554;
        Fri, 3 Feb 2023 11:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=cGDwURdaaoX/PBxrevdm233oKL0PLSwlTCP+eExPp+2qyZO7CBOZ/bRrwz9IktAOptAR
 iWqvh8JqoJgooShpxHq9W3wMt/GVafcNXnNvqwcHNG7fdeReTnQEo0rSNu2zsSiEmIJ5
 fJA1pUcJyMRvwCGKOPZKR+zJftk0HuRDiu06FGLm6lkhxuDXE/celydc2XBItdGnhCmR
 Rdb9L0zlexEkjbQjLMJK85shpOEDslxumyy//YdJDgXuUAqNL0/CJyfueIxv+hG82hDg
 k10BqkuFiznqG4ZHmQVb6hM1zuw+SwW6s/ZkjEfrZpG9m/CVxm3igh2XpWRw9jWYm+jx +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfpywn4gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 11:38:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3139RYZb034219;
        Fri, 3 Feb 2023 11:38:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5h1aud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 11:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBqAwxWRmgg3/bKtIYPXFc24Y/g8rD+xaETMDHrrgZuIOxpqoj2snhjH5v/RA+whv+iFmB5FR0Y/rD1sq/35DPAjhx7kagvNGXVFfbd+rMqcLQrxCQMIpYMhePbR4rsCAiJc2AOKz0aMs7hdS2oCD+Mo7MSbdPm9c4DcKrrD7lXK37dYs0Yr4lAtKs2DM1bYAEYgZvadOdQthTLAeFf0u0TIGvZaJsjcylEx2M0+fo6tsi/URGyaLub8ipddvfTgfB91qkKhmIuqt9bGoeawWOOOc+SawzzoJFA4+PABu8ppQgfM+UHqXbx4xHmJUXGmPSYJI8o3+lZ382PDLfVjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=k7nGPVMF+m70AYfXJSlRLnReLfJ25gouDYRB8ajIAiyOloB24s676M+sbhmR+zfjq7kkBsO3r2RO014OWK3AA6OCeduNrp02po6/K2t3FUkCP2GOa9IvF9xVwBHvgeUuvdwBQ9iaHvJtbcKt1/viK9eDiss2Ft6ShIQKZE7Y0MdVBIltvBSSjrbj81OHVoSh0fHvrVC+WWYFEuxYdCZP23Y4Kp5BQYjS4SYGKppy4Nf+0KZhHCKVg3+nnCXR575xlirJXcrpFcRj2jl+jwdlYNdXHBr0rw/wbN1v3D/ij6VO0tkUdjYFN25GoALGVNWLDsw381wMP9hEtoLHCNHlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=dc+RTAWrlAQW7WpbMUbH5Lam7xe87WQudnXlir8PmwsO0Zl4Yxx9tx289Q7yo9JMs5PX54xfC+zIW4/N8M49KzR5aucJNTi+WQALY+rq0RNnFbz/u7j+g3h0NDBx1dnWwN7TSGFDvY422ywN1RB9UC4kL7bFG3E1KsN3F+866ys=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.8; Fri, 3 Feb
 2023 11:38:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Fri, 3 Feb 2023
 11:38:37 +0000
Message-ID: <7cb469a6-cb09-e349-90c6-dbbd99fac4ad@oracle.com>
Date:   Fri, 3 Feb 2023 19:38:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: add a stress test for send v2 streams
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <a2a5700b744bca710ff0721f1d1fa268d76430fc.1675353192.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a2a5700b744bca710ff0721f1d1fa268d76430fc.1675353192.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 951978f8-c189-4077-631e-08db05db306c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YzEHh+igbgeg2QjxxX6D4MFNEZf0PbEBLUoHNMtTZ8iPRQiomUVErcVPlyBWqJQbATNm5OxIYMx04BelPBhx5UwEklepW27SOlPYFybFp86YuWFkwvfrFn6MKT41dJNsDQPSUXo9Qivh278ZkDyh4cUQRvGSc/dDShH10f8+K446pzphAu530xak9wq3DsF7TQLiuSrqVZd85xgTZQSxQ79dbmLPXFzXKl5g6D/5CamT9Ki6d8yABk3x8CbEbFPHBvhq1nqnz4fmNdczFlksvlewPTxAXgq9hnn4tBHahw18FSjQNzloMPQMcEtAMuKf1Smo5IWd2TQTITFqSjwyqyAfT0/c27PKYLAfN5NIWHJbwgf4UznBSdjk+YuAWMG3ZAKHuXk08mmXk4TjNfbkfA/fRa4z4UtNcqJKRmUV/zFuYpuvmYJW/LwIyF5ooS1e9Iw3fKabLzHi3Y/A1/8G7qF9o3Z3nqWYv1+QphfoRwPlsd7G9Vzi7lZx0Ae9lCbSy57Hmz9y4Gba1oELjpnOyn878kYeYFNZ1Ha97HQJeFIE196k7cpd+r7nLvO0c3kcK8rf7rkNYKk184jkso4/hqlT5cKuo6DeUBEs2leZjt5m6vPiGmIfdxoZRTiZnI4PgFJD2su0POnPIDmPpZMYq9h6mvk8uA7nabYm6JrYhf3jH7tzy8L6M4fH9pDwGwxwwcc6ai5iq2GKgP31X6TWDKW5ug8sS+zax7YICelRc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(478600001)(36756003)(66946007)(4326008)(66556008)(38100700002)(66476007)(8676002)(316002)(4270600006)(6666004)(558084003)(26005)(6512007)(186003)(44832011)(6486002)(6506007)(5660300002)(41300700001)(2616005)(8936002)(31696002)(86362001)(19618925003)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1lS21WN1p4bkF2OS80TEIrUDFIbG55dkcreXhQT3NWR0JUaTExVEZQYlQ0?=
 =?utf-8?B?TVo2TCtNSUJ1Y0NObFJBOG5TTGRvZWU5ZUFrWDFJSE9NMjhaeWRHdUhYcU1p?=
 =?utf-8?B?RHlwQkxQYzVIbVE1bzhnaEdvYzFSbVRCamJtRnV0M1dpdUlvOE5XSGdjT1p5?=
 =?utf-8?B?THFmNThaaXhZbGtBaEdXR3RqaWx1Z0d3SXBQSklaSjQ3V2E1Um16TjZZZXVl?=
 =?utf-8?B?NkRDcmc2TER0U3doV2llR1JKQ0JGQ0h2bHZhdWZFRHVHMHhLTTRmYkJ1QzM5?=
 =?utf-8?B?SFlVWFhGdWY3ZTA4b1lMVkxielpjclE1ZEgyZGJacGVlVGpITWJxU2ZuVU9s?=
 =?utf-8?B?bTdmQmtRYXBhRkNlSDVwNDkyQitxeWFXNDlhWE1NZC8zbUM4anNNTU5hZFZS?=
 =?utf-8?B?am1qcXM2QnFnRER1UHltaUhIeXZQWEpPRmxEV2E1eUF5ZEFNMi96aUF0VUcz?=
 =?utf-8?B?UlUybzIxbFhYY2lETFBTZDVxbzJEL05rdmZmMTBwTWEwYm5jV2tTOE91em55?=
 =?utf-8?B?Z21FSU03anJqV21SUk1RcnNQd0lHbktDb202bkxpeGpLK3JKU3VzNEhBa2Ji?=
 =?utf-8?B?S0JMZUN4SXA1eFB3NFQ0UGJxTmhxWkhpR2xmdDEwMjVQWndFWkpZeDY0UGlw?=
 =?utf-8?B?d1V1QVIyVjdweWVrZGEvMGFDcFRCdXJKRXZDaC9ZdHhtb0gvQm14SlY4ZjRH?=
 =?utf-8?B?akJNMEFJTjdsUEVzSW1DYnB3MTNmaTlHWlRKQlBjRDBlNUdMelNQQmVVZWpx?=
 =?utf-8?B?WUtBY0V4citOckxwQVd3bFcvZVRMRmxtU3BkcENHOFA4QkJmR3Rjcm1YMTJa?=
 =?utf-8?B?dlZlUWtCZ21QbHdjT0N5Nzk4N3hPWGswRHN3UDF1S0dZZzQ4L3I5UEo0Wm5H?=
 =?utf-8?B?aDI3UmU1aTFHZHYxQSs0ZEY4YXg5WGhlVGFmbVh5TE4yQk94SjhRcFE1c3Rn?=
 =?utf-8?B?dC9UQ0lGZ01QQkRubjQ0OGZoakNBaEJGZWkzakg0YTlNaFExSGhPSmNHb0Rk?=
 =?utf-8?B?cHRVYWJBTkhZQlNMWTdFekhXQWhzby94RUdCZnExdDQ3dWdHclZXNlJ2aXpF?=
 =?utf-8?B?VURCWXVoeDdwL1NNWURsQnlZaUdGOG5PSXQ2WjhhUEhSM042MnoyeG4xcFZN?=
 =?utf-8?B?bXpPQWxDYTNNY29FNytnSUZ6ZVhJa2FyQmQrL3NNcXM5Tkl4NGgyMnNwSUJs?=
 =?utf-8?B?NjZUT2hLeGFNRnNjME1KYlFDTUtHWGFsOUUrVGRVcXFpNmVVa0JUbWUvaUJk?=
 =?utf-8?B?TGRJS0szQWpyeTMybm1sT2VNZWxlZlBmZktNdXE3RElMN1d1Y1BxbU9laXRZ?=
 =?utf-8?B?MTR0TGJEWXRRaUp0TkpodnNibHFUZHloR0hXeUhSNGo1NWZ4OGUxWlpNTkJM?=
 =?utf-8?B?clBBMXpGTC9GSXBwVkpBM05QZ2ZmMWNQck43WEUxVSs2Y2MzZmR3eDc0dVJO?=
 =?utf-8?B?azFRYkQrYUJONE1LM1c4bjl1ZUZSZkFhOUdkaFBqWXVCRzJEUkw3NGtqZ3E3?=
 =?utf-8?B?cmd3ZDhMOVdQaWgvK3J3Q1FVenhBOUlTY05SWmZoZHBPczRONnJ6UTFYcHAy?=
 =?utf-8?B?UjljdnV1S1hKR0hIeEJYUG9SclFxTWxyOTVIekxBYk9zc01ZVks0YXRQdEh5?=
 =?utf-8?B?VDRrTXJJcWUzd2RqOTFYQVFObWg5dXhPeE02bmE3clp2R090aXhvRWNEQjJs?=
 =?utf-8?B?RGlsL1BkcEQrUmZJNm5nRnY3K2M4bWFzMWpxTCtWZGVOUG1tV1p6MGdiSEFY?=
 =?utf-8?B?bXNYTlp1SDBKL3d3bVFuZ1NBdDZ4U1laU1FjWGxOYTd6MGhpQTZqU0srWTVD?=
 =?utf-8?B?dmZsTURkRzJtODArZys3MXFHKzlnMkJER1Jqd3h2N0lvN2ZsYUZZeWhvWVZO?=
 =?utf-8?B?YnF1cTJISEZHS2lXR09IZ3QyTUd2WHhtL3JubXljYzNORzdhaDUybUlYakhR?=
 =?utf-8?B?WGRaN0JiN09PQnVRWlN6Ym5oMjJ1cHByQ0NwdnR5Z3VPTWVTTUtwZzV5R091?=
 =?utf-8?B?K2lnQ1VNd0dqNEtCWjhPV2pqQWFUaHd1TEhPdG5POW81ZGw1NzhxdFdIak5N?=
 =?utf-8?B?TmtOTDlaczE3MGV3VHJ2MTNERXRyS2E5L0lkbHBhZWlZNE91OWFFS09kS3Jt?=
 =?utf-8?B?VEYvSHc1UkhrVkh1T3lEQ05GeDJtUnRlMzZMV2JqOU5lSWRiUE5ZdWhDdjBD?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k+7cKjIyaBv7Zq2Pe5ZqsvFeSvUDUhrUOD0UNu3vJ+vEXDlOOU1eRqYgx53Z5LtYvwRcYWAmYs9r1FYNFuhoB2SALVxDU5LxyEvCm3olYcgE5zCc8NcGVu07E5UJhJNgz0i6SrxuOfYWnFuTycP/EN1leO44hjvz2B77K4+68wvE8LHheDs3fhiycMhoZmPKA0jcePoHQxDlQApZKbKM3twR4H95KA+1Y/82USvPNak0nc7oPxGznEOBYxfsLGWFskDOpZLJedIWQbTxrjimrQ8i3s69Rs+rdr4fsKV6SnAQyssFXGY5i25Edq+CKp+0FqEZZwGvR9xwVgYn8bDJlXlHsJt0xg5gbqjZSymkL9R7eB096ZOWIhKysMDCM91E4o3Kn9CIwHd1e7xdmCc+N8TdM0pVy5ax+D62dl8DSSjiHuzoIgb65t1WHXukaEgIrZ5bwof12B1RzIASg2ImkdloseF7aNZjc3LrZHldk4RRAu6jTZjzdIUs02DX/3IvMFDPplojldZs2+b0xg/h/FNCmanZM/PqYPM4MK0+Punud+zaNshmXCqipdjETEq13wT7/i3C3BNPpCM3DZ2HLGsBvvGf8sC+/OPFc/3fMc/Tjkk1OmkdGyti+lq5Nkd6SNK5DfZU9TemJ91Tb7TMSZlKKYz7Ltjy+0EpdVoMvD+I4XHov020T+LTqMcnwnoPTgcFlzmgZVPDOFZ94aOaNa78Ser3akbilNZ7gvf6kxj+sfZ1a6bzTmGzcJIli/qisVYkx9SSqUfxvYhpCPYoL7ysE5lCGYSbp8HVgMCYdFS+H+LRveZ+edC9gzanxQk1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951978f8-c189-4077-631e-08db05db306c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 11:38:37.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwTU5R079X+QIpkXGVqIDBY/xr4xoD9D7ggQUsr2DUavdyjeaOAdkdz32dPaBAjge2QvS+zxgPQig0I/YGWRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_08,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=905
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030106
X-Proofpoint-GUID: IJy64YmVuZNrgyJOv83kyyxraNI7CHdW
X-Proofpoint-ORIG-GUID: IJy64YmVuZNrgyJOv83kyyxraNI7CHdW
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

