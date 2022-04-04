Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D44F1C34
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379352AbiDDVZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380640AbiDDUrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 16:47:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDD13E9A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 13:45:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234JLkeV012570;
        Mon, 4 Apr 2022 20:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o1VmTikoBS8r1+HbU7JFKdGGDz/P2JHsaO2XillP2nk=;
 b=crmwT/8MnqS0CRXS4A/PAwQIZzfMAvv38VeVSJ2vgULgg2/1ZS5rJGBLxRo7J2razRpE
 7JaI9m3ONv84E8VWo3ooOBt7X03TfzR4H83UCi7b1Upo/of6YBPUSKTF4+YIFHVtkUs9
 6SRHTGAdap9UigRJ3mv8iIONEQHLB2a0bVJx6mReZTEQwEruA+fVa5TVKHfnor3wZMDP
 PvkZwoZtcJ6Jqg1Dng5/EtUXbpRr9f/pXOK5IeEve6+IuhsqVSid5y2DBTisoPvskNE3
 Gfz9rOFI0+mexPdY5wp+XVEZQhe0+FgT61mGKY5AEStprv7QtqJNExi5Yzj2dPWz0qna zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwccaxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 20:45:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234Kas7a040212;
        Mon, 4 Apr 2022 20:45:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2y0pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 20:45:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF5eb0bQ4sKlgKjtqi3uLG3yCi2mpUU4wToqC/emEP953m2Zwb5tsjn4j5b4oHsvAtixZtF8AcSPWxWZ723cqOkI3ZXqOIIIopfhRPctg8Ax2Y7wjm+qQdmcCzYTMH1BZzPZyAYOE93CTd9LcdOppWFRpYQr+VX6SKrzWewfV6ajlr6j6Nx+cnTa4F04JRni0VLODNn1ngduFPlmMjEbiCCb22sNffbp5jCzJBHIgy4PkPaKxoAbEObwxrITSRrlPQRzwVeFGxpAa/xebXTWeVCgzd/RhSYKSe0H/xT+WmImv8Of8mBvf+xr2Tjyk9Am4wtvSORa6H4zz2SCKOACBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1VmTikoBS8r1+HbU7JFKdGGDz/P2JHsaO2XillP2nk=;
 b=GHlt15AEZLcO+yVsDZE/Lbe0maHjFUdCz05S02owuxeuRGMttecHuGMF7JXs8hC0fwHMyPrOpjeEVHQ4JBBSX5AzOeTBE/ZZ28c4cZP8erxhzIJkhWNVoBHr6SfMJg17RAHKV38Z44hv3/+UmJqhqraAcJME/R+Ee/1MyvYGq5w1ijY2cnBoGPZYMl2iP8zxvfJ6WKYNa2kT5N9C/PPCsOuQ/SrB/g09/3P9AGhISC2AwQczwzRmV08trJ/7keBFTc+4pJ6THVpiSl2E3R4ckPnRZsyg4PCXVylCL7f3ENjiznrNTtyWRBHuYTUvqjuUeF5+RNLCZVrPrY5GNNnrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1VmTikoBS8r1+HbU7JFKdGGDz/P2JHsaO2XillP2nk=;
 b=Q+KEXqcuX6PB4lYvQu3i7BVpESzqNtbEPOsmwO8Xh6B5isOkoPG3MQCdIm7nu4HzDYx37aZzGNU0qVJabWZuVIZV2rSfUwWUo7tl8ZOF70nFXEh8ZwNyzKM0LmD/0in/7a8QNN2Zd5jE4yG6lXPNQQGVqoaaLsePTZ9xzJCBXeY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB3224.namprd10.prod.outlook.com (2603:10b6:a03:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:45:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::54da:72:aa08:9a8e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::54da:72:aa08:9a8e%9]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 20:45:05 +0000
Message-ID: <837cdf72-727d-b46b-f5ab-acd16be7006a@oracle.com>
Date:   Tue, 5 Apr 2022 04:44:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2][RESEND] btrfs: allow single disk devices to mount with
 older generations
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>
Cc:     Daan De Meyer <daandemeyer@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <75f38ba99fde2f94066fb4578914241c0e2a8f9d.1636408300.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <75f38ba99fde2f94066fb4578914241c0e2a8f9d.1636408300.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3054917-df07-44a0-11c7-08da167bff98
X-MS-TrafficTypeDiagnostic: BYAPR10MB3224:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3224A53EA5851798609E7576E5E59@BYAPR10MB3224.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lr3wXIal6DyPkQ/EJim2C4d5H6xAQN5jVCCoJ/FFIhfAMjn/c5oWiXTo6xSAvuMmInY50INEkLgtPwPOGXebieIGGuXAjmyn7XL6zpTGjvfTwNCadCne/r3F8BZZx6HvKBcgNTkMeQWfqgcY4qSqhJ71ZZrvtQEMvHzmFofJJG0Ig9GjX026yJDPcNg5nnFJGzA6TIfgD0XPdIR+4pmsu1pJHGKp3TlvsT7E6uwzFVNqLWzs8GcB/f58yd58P94QGpOMEUhpRl02H0NxLDQ8smlboUVed+s/1NzTo0Np879PcWkbrM1oV+xM8UY483xjfmfooBx0oD2jZy8oDpNkSRaE1u960UxVJ4wofRFAPft9W75+0ue+4XbYt9oWTj/D7meNTQnbNDTW4WZqA4KzoPS/jpebrAXTw2pVG0UpAhyW2qH8U53j3EzW0lf+yvYB9DiXB4gHld3+tAsXyS1jJoAy7PNrwd9sqr7sUpvGfyZd71vi4cxZ46pk8FzOK+8FkntsG/lgbSQDfzPiy5JrlVe5SJPzkvV3N/RR5No88DbYfBGWU22YO5UHHkdl7IHJ5AD8oC0axN+wG8CWywb0z+4+kIY8OR6g9z1b1CrdclpPywTctfeajqGF4DioahyQSByGGgllWVrdsI5Qr5iGe3ELpSkaYBrdxROt3OIKpUuDpm+6dsjGzVdF3BRkDxmgmYLLHQcCK84+gOFnkzvGA9I4sXgnNd7DJfKUJ/eqHXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(36756003)(53546011)(6486002)(31696002)(6506007)(86362001)(5660300002)(6666004)(8936002)(44832011)(26005)(38100700002)(316002)(6916009)(54906003)(66556008)(2616005)(31686004)(186003)(66946007)(2906002)(83380400001)(4326008)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNCTm9RSGw3YlQvN0grTnliWUJIQzAvM3kvT2d4cWFReDZXcnpKVk1XZGxH?=
 =?utf-8?B?aDNzRmZrWDZCMDcraDNOQ0ZHMnNhbTZvQWF6UmhxVXZyaXBiaGc1WWpvSWVi?=
 =?utf-8?B?Q2NURUJ6L2JvOGRna1AvZytHRU1BdlllLzQzMTBUYS95emthY0RET2U1QStz?=
 =?utf-8?B?ZGlaVHl3NG1RUHgzeW1RcDdQQVhvbDRHVy9MRkJ1VmJDOFFZTDF0VjhmVnBC?=
 =?utf-8?B?d01BVjZRRG8xazF5V2pua1h0Lytmdng4Q3RpQmU1c2VhT3RkcWdvMm16bFNO?=
 =?utf-8?B?OU9XOExSTEVhR1FjVmtkVXZzR1VoU2M2a1k3dUdPMEREc0FzenhwVHl5bGNq?=
 =?utf-8?B?ZERjQTdLRVNUdG1MQ21JZ0l1YjFiU0xoaFlrYlZmc3BVZ3p5bGpYQkVBaXZW?=
 =?utf-8?B?MVQ0YjBPZmZWa0JUZ25ZTnBhdnI2ZEpkV3ZLbWNGaHQzck15c2FacGNOUEFl?=
 =?utf-8?B?MmdKUVdkWmFhaVVLbUZ6QUJoWXM1Qk56d3pIVEVFNjErSEhhcFBFZlJZRm9O?=
 =?utf-8?B?MlNvMWlCQ0xmbHd3T3dNdlJNcE5CdmJ6SEFmZ3dTOHBCZDdiN0NFQkhkL09B?=
 =?utf-8?B?VExQbzg5Mm5MTHhYSGJkNHdBbFV3RU5qakdrTkpuTUJ2M0NzR0s2RHprY05v?=
 =?utf-8?B?dzA4c0pRaStBNXlMNitGVEw2NkVna1BmZEoxTXBCamJzbXY5cEtIbXUvRlB0?=
 =?utf-8?B?RGJJOU1GelNuUzJOTGpCVURnYktVS3Z6TXF0WjZKU1RHK3daS01YL0xjZXR6?=
 =?utf-8?B?WHJVMWovTDVpL3BkK0hlT0pxK3B5dElyVmRmd2ZSUW5ZeGxvQmVBRW52bkxk?=
 =?utf-8?B?cWlVWVg5MzBpU2RSMlQyeUY3MmllVW4wR0VtZ09ZZkduVkNFRXRnOVpZTkRK?=
 =?utf-8?B?aytEQWJLQXB0UjR0OWg5NThibWJhbVBEeWxWUHoxRU9pSnRwQ2ptWG9qdk9L?=
 =?utf-8?B?SGRFQjE1R3pQWHBTSTNlcmltd3BycGowZ2duQlpDaFFQeGZKcExveTh3T3Za?=
 =?utf-8?B?UmI3eEMwcG9EUVZPTDFmV3Ztb3JCZXpLRGM0SDdaNldURWxSVnpRcUIwV2RE?=
 =?utf-8?B?L0F6bkIxd1B5RklKUWttQVRIQytUbjJZSEdWMmExZ3h1bFN5eUlwclFzWC9G?=
 =?utf-8?B?eWpFUWFOVlZ2eFE3YVMrMmlwMHo3Tzg4VFBaSDdNeGhvWXhVUUV3T2QvSFVI?=
 =?utf-8?B?WExEVnFnUGRtVjhqOWVBdlBxQ2J5NjVZQnpudVRtR0JLcTJwRnptM29zLy9s?=
 =?utf-8?B?eUd2L1ppdzdaZXBQb0Z5YWgwMXlKYW9CV21qVFg1K01GYWM5RzRHN3pzYzhi?=
 =?utf-8?B?RG1UWktnNmlLMkswa0Vlc3lLd0NuZGxiY1Q1THFoc2NIaG9mM2xsMko5dEs5?=
 =?utf-8?B?bFEwVkZ5TFRIMDZiY0YvS3liY2hWTWlrWUgvMXdzNnN5WWNNY296YzlPdDFn?=
 =?utf-8?B?UjVnaHQwVmpZQ0RtUzhlSEtrYU0vTG4zcUdJNFZzTlJaNjFMdlA5UWlCMlNS?=
 =?utf-8?B?T0hHbkZ6czEwUG84dmsxbWVLSTNXYXF6KzZQVjNPOXowbUJRNzVPQnhMVGdG?=
 =?utf-8?B?Y21rUlZqZGdlbnRJS1VKWjRmcnNGRXFNUmhYUzQwMWJYY2duUkNrcXJ1VkYy?=
 =?utf-8?B?dU9BZjZEN1JyVWthTmgvRk8xOVE5UDJOeXNTK3Z5QVZSUXlTYXhkQXdHM3dK?=
 =?utf-8?B?cUFNSkJTcmVpQ1BNVnJZSXEvUW4rR0tIYU1rQzhsVElseDBqYmxOb2crWUNJ?=
 =?utf-8?B?QjRUaGJBTElmejlqVDlMWkVRYTEwbzNhZ3k1aDlvV0ZucjFEQTJHbnJiQkhR?=
 =?utf-8?B?RkFjcGdUQ2dkdXFCam5MMld0TXVpK29Ub0s4NWZwY0hNMmg0RWttWXFESFZF?=
 =?utf-8?B?ZWlwSEpZTlYzdWZiemJDWTVteEtvT2U2ZFh4ODZsVStjNnhhdWtBTWxKZkJM?=
 =?utf-8?B?aVcwdFZsRWxLbzRtMVFhaFJEaUFJMHNPZSt2SVlXR2FtYk54QXpJalVrNzRn?=
 =?utf-8?B?WWZJR3VNczJSZHZrYlNYczJSZHBON2tFR0N5T0IzL1VCY2ZDOWNkMUJ2YXh1?=
 =?utf-8?B?ZytaQU50M3RQSlBWRGVpdU5sSnIxdzJZaGt6QTRnemN5V1RQQTIrT1RUWHov?=
 =?utf-8?B?WjluNlV5c3BEeUVSeVROLzFEM3RQbG5KdjhWbEtEK2gvNjc5S3MwZVJUQXFR?=
 =?utf-8?B?dGdwb2pxdXBKTEZFR0dvbGNZRkE4L1M2SmZyWFhxWlFXdzlGbXJsdTFBMFZs?=
 =?utf-8?B?T1V4UFR2WGd0VVlIbXZieXBZYXczVkp4SkJhc1BRMW5ySmF0eHkzVU0rejdV?=
 =?utf-8?B?NW9hQjRBdkpmdmZqUFo1d0hjVGFVTURvT2RHelRlUXZ5RmVTMUJpZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3054917-df07-44a0-11c7-08da167bff98
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:45:05.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zewIDaAO2CaCLZO7OytFGJw5InfgCY0lF44o82EDDGbjJYbXvVpnC+bFxEh0N7bQfLf1/KVPqsNc+lGB21V3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_09:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040117
X-Proofpoint-ORIG-GUID: JdrOokYHZyRO_wJ1Qiy-Bs9IXrOA4GYG
X-Proofpoint-GUID: JdrOokYHZyRO_wJ1Qiy-Bs9IXrOA4GYG
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  Ping? I find test case btrfs/219 needs this patch.

Thanks, Anand

On 09/11/2021 05:52, Josef Bacik wrote:
> We have this check to make sure we don't accidentally add older devices
> that may have disappeared and re-appeared with an older generation from
> being added to an fs_devices.  This makes sense, we don't want stale
> disks in our file system.  However for single disks this doesn't really
> make sense.  I've seen this in testing, but I was provided a reproducer
> from a project that builds btrfs images on loopback devices.  The
> loopback device gets cached with the new generation, and then if it is
> re-used to generate a new file system we'll fail to mount it because the
> new fs is "older" than what we have in cache.
> 
> Fix this by simply ignoring this check if we're a single disk file
> system, as we're not going to cause problems for the fs by allowing the
> disk to be mounted with an older generation than what is in our cache.
> 
> I've also added a error message for this case, as it was kind of
> annoying to find originally.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Daan De Meyer <daandemeyer@fb.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 68bb3709834a..9dfdc7680c41 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -777,6 +777,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   	struct rcu_string *name;
>   	u64 found_transid = btrfs_super_generation(disk_super);
>   	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
> +	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
>   	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>   	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
> @@ -909,7 +910,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		 * tracking a problem where systems fail mount by subvolume id
>   		 * when we reject replacement on a mounted FS.
>   		 */
> -		if (!fs_devices->opened && found_transid < device->generation) {
> +		if (multi_disk && !fs_devices->opened &&
> +		    found_transid < device->generation) {
>   			/*
>   			 * That is if the FS is _not_ mounted and if you
>   			 * are here, that means there is more than one
> @@ -917,6 +919,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			 * with larger generation number or the last-in if
>   			 * generation are equal.
>   			 */
> +			btrfs_warn_in_rcu(device->fs_info,
> +		  "old device %s not being added for fsid:devid for %pU:%llu",
> +					  rcu_str_deref(device->name),
> +					  disk_super->fsid, devid);
>   			mutex_unlock(&fs_devices->device_list_mutex);
>   			return ERR_PTR(-EEXIST);
>   		}

