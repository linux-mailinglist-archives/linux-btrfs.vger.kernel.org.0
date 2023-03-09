Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3150F6B188F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 02:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCIBOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 20:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCIBOh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 20:14:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE1C80AD
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 17:14:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328N58dQ017675;
        Thu, 9 Mar 2023 01:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hPB6ijuTRYDuYX2BRId4gWClfbGMjtPTmCI3lbpPeF8=;
 b=T71jE/A4AXf61HiDk2J5RB/K85ih/gt2vQwXGHavhcQIcaxPgXvbTkeL0tSJHwsrNIp/
 5C/xNk7mnc9/tZXHb5p0m1KhPb/vocHx4z5NWiuH8wZAKHnD1DiRBBxJ3aZEQgvffSpD
 zTnXmJcaVAX9AL9vwYkxZxR+oSJQKosHtw8Guofh3K6Bw9mGAb838YTx2Sq1AVf2629h
 zFgMax8mjosPSsKXS1pwITBaXyUebeIXR3ovm0plLirzaD2kT8EfH1UuuGWAERjBtINe
 QMjpgU6Th41HtkGRFopF7yzmnZh8aChFGVL/TuVg73iH6BWrPx6zE2IRQhvy6ARO1VJ2 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41621ft6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 01:14:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32903gCt021674;
        Thu, 9 Mar 2023 01:14:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr9jq50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 01:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuPNcBBucBxhVbybHLHLcVAcBjbjgEKNT8TpqSOIUAvPZOrd6ALC3FDxCfr1hDo7RGCO0uPZVKZrkDLFJsdBX7NvUUNwDKOGP2+M4c5ldNKeF42ygwUsLa5XIoVKtH8zHzlbKAWx51U/pWxD1gLapI9JEcjFWSYKJbfBM3WPR2GX5zq//gxMX2O6GVy7ltevC6Ybcli3MD5WTk1+DRbn9V562TH3z/Jo1p2w8Kd3Ke82wIIY4accsUiD4lSncgbL5McQilxn7zAHPzPRiqfYRq3a1LKZaVkCJffeXcLTwE/8gV3sLiQeciGAUyasLKRSa9NO8dpse5yQZ9YyA5/L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPB6ijuTRYDuYX2BRId4gWClfbGMjtPTmCI3lbpPeF8=;
 b=EbSoIJh/McAgvOhPtGM4mdh0sY8RTV25Bp4ciZqNUIXmfHKCADDrwpXXjyarkVvNQh2jmnwVxKl7WJFKNmbWo8I4+5XXBrAle7CVJ+lgBJrwO6dhcvA1wngpAv2ASd7dc6J0IjXvvS7mmYPoIIE7rIQvVvjcEtlorFATXsBw9qFrWEHuYZG6agsxEXdtss6Bt/isvl8Vbf48n4ubdsXgRH0nBuoQEWU3NzO8JVkRp06cuEVyoJfSSCjsE6dgmTIQaLh/ncRngG3obngoPsWRjo7S8aWBKZLFEUglUqpErDOlD3zBCqVLEPjDI/Z8qfFzPDduM4CbbDYQmisD81qNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPB6ijuTRYDuYX2BRId4gWClfbGMjtPTmCI3lbpPeF8=;
 b=N7GpCe8T1wLRjBUdGEYbxflxeXBLLf3W4wQDGtyR0mLGIKNbKvOx+yzSPAI2r2PlN+8J5DYBZJ14q6DVSGaLgbwTV19zbu70bLzm9yX3YOAuVMKYieBjcMGlLO3SbK6hrgjmiospVT3odonS85fr06eKRpnKWrDOuaD2pjoPvAA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 01:14:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Thu, 9 Mar 2023
 01:14:31 +0000
Message-ID: <39fd6b09-5a47-abb5-bc5b-f53c78dbbfcc@oracle.com>
Date:   Thu, 9 Mar 2023 09:14:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
 <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: e910f796-aa21-4afa-0f4e-08db203ba2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HazLO+NzFvFkD+4aQi3fqIeNrB5Fm+9EY82gNgIhp1gyNT5O/YaIYEcSFOZLhKv7dviXDObjedr/Wd/c46gnnjkNcYZMsPIFf0B4vEXo4mBUhttgVD+bTqdnT5vwpnVrJyywIcBJ/u2+BgTOikzvBO/iIw93qfVJtRLkE1G7Row+m6GyW3jLUvKhSflenSu61DpYyibDccgswgdthhT5oLKTimWyc8OWPmHmGjFWx98XNjcblcUll6VK4MHNHiqDKuzISwG1Je89fK13hd37Y3vxLpjaAHDc1DT20l39WANuJCyGGHGMgevEJI7T3OVUTjkRfcKUA69nn8hOvNTiiNCdvgnCO5rKCg88yIOBQEbVT0zJdTbHAR1wGq52G1SCyZ4vJVH8GjnrJNDUIYAArhWLgfRynfye1k1i0oIdLFcHXmxm7hSbvj2oAjgQrdRcV5H5eWvMpZ8oP3fLvSYalmbeqi1tB0OsZYji8WFjqHR7J+RT7ni1MoJPjwO6EN4qOmFrT+EofKe5jkeHRhPNEbA+FBQ8mCak/XV1xMSU9qskYVCjN1vjic5bdz7cmG6mvfwRRizvzkHS6xTA8KYc349KTRdJV9TkxPMnffDaJt5TfIT4qWeqKC/+smtNvD9r0lf3VHNPspjKiVVY192nZnGiMLMctRHdbaQXpDADXtMz+MhkDqdAFVEy1pPSDvThM9LC5Q9gPCvMW2vAEhRYcWYvFa4lhBH3mutCLCHBhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199018)(2906002)(31686004)(44832011)(5660300002)(36756003)(31696002)(26005)(8936002)(66946007)(66556008)(66476007)(41300700001)(316002)(8676002)(86362001)(478600001)(6486002)(6666004)(6512007)(6506007)(38100700002)(53546011)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEY5aTBtQ09QMGVYd0pIQ2lIMWF5RWxzT1p1RnloL25uSnI0NEdUcXBjUmRC?=
 =?utf-8?B?V01QUG1xaE52eE9CaC9Ib3BadWUzTFlLazJUcmJqMU9OcUVsbEFjUkdhN2Yy?=
 =?utf-8?B?V0JJMmRJWElpMW94bWdwUEpqS0JYNU1peU0zdU1CT2ZNd3dEa0pxK09RTjNJ?=
 =?utf-8?B?cEdSZWszZzRBRTNIVlg3bjBaZlZ2cm9jNWVOV1N1RlNQTFk5TVNHMTI5Slgr?=
 =?utf-8?B?OWN3T1NoVnd3WHVOUXNCanc1Y3FySEQ5bFdkU3hUL2RCbHE3ZVNrWU12dyt5?=
 =?utf-8?B?cUl5d3RHdFp6Q0c0UWpKMWRlaEw2NFByYmtZL1hoU0JPcUc3V0t3dGQrWWtY?=
 =?utf-8?B?ZCs3YUVkWkYvTVF5OURtRm85dkJXZWE1YmVxM20zWG1CTEorZDJ5Rk9CMWQv?=
 =?utf-8?B?NnhiWVdCOWRCbStKQ1hLdjdjdzY5Sk1XNUZ3V2tMbWVZdUQzNmhFaHI5UGVS?=
 =?utf-8?B?ZnRBWEVlZElXMXVTLzhnQTJYTXErQ3Nmb0xZc2l2aTVodDNWYjRBQUViaTVC?=
 =?utf-8?B?Wno1RGY3NXlBamFNeHBTeUM3Ym81L1lzaGNXMTdHRDY2YzF6enphMEorV2Rj?=
 =?utf-8?B?MXFZcFlvTjhkWGZWbFN3ODFHY1FzZnpYeE1RcXNaRHRKWmxzY1k2dVRsckxj?=
 =?utf-8?B?YWRKRHlPS2R5cmtpSGpHT1g4dVE5b1hYaTVWRWVFalFpZWhjRDA5ZGNObGMv?=
 =?utf-8?B?Rm5nWGg2eDB5V21JT2dHeFhlamtzSUxCa2liZ2REam5aNHRVMFFFaGtVV3Vm?=
 =?utf-8?B?UVo0VEk0OWw3RW9Ld28zaHBjWDd3RnpIVFQ4ZFRISHZNaTlSZ2k0TlhSQ1FN?=
 =?utf-8?B?R1ozVU53ZWdxSnJVbFFab2tyWk91Q2dtbjVsYysrRFZxZGovUVlSdEFXS2I2?=
 =?utf-8?B?Z2VITGpCUmNBMS96UVZKU2U1RER2dnVWQ051KzA1bzM5cDhUSkFkcjE3eWI2?=
 =?utf-8?B?WGU2QVRpTlRFMjRJVjc2NDBqVCtsVE5va25yTUZ4T3o1YmFLSE5la3l2NkpU?=
 =?utf-8?B?WW5jTzZIWWNVemp0YXQwY08yTDVHY1g3WFZrUVFiVzAzOGtic0VzTnpoMGVG?=
 =?utf-8?B?NGdCeDBFQk1iUjdnbFpsWlFtVFZrSndBKy9RWUlBOFZuM0U2ekFrSndlMER6?=
 =?utf-8?B?RVVydHZjK1dqNnJhcWlPTDUwSS9IMFgxTzJ3KzNQeDgzb1dMQVJ1NzZpMUQx?=
 =?utf-8?B?MDNNTlBLbUlJM0pVdTRtT204UWZURFh3UDZxbXcxRzlKaUIxNEYrZXcydm9V?=
 =?utf-8?B?VkxjRWJsYmFlU2NmTEVrbDRWS2FaUHBlaTk1Lzh0VXIvY1cydnROcUN1OUx3?=
 =?utf-8?B?VTZDZjNCMWhnZGVaM3QxN1VnS2pKd1NHR01uR1FTbnF0R0x1VG15d2E0MTkw?=
 =?utf-8?B?ZWZnTXBNUmNQZDFvdU50N2dQNU1IWHVVUkJaVnZOemJBZXVnSHhadmswRGMv?=
 =?utf-8?B?YkFJTEEvRmRReXNiSCs0RUNKT05SRDJseStXSk9Kc213Z2NkaWxGa3F0NU9t?=
 =?utf-8?B?ZXdzbnFuRGdyblorYkxkU2x0Z1NjamtIamxNMzJrbnRYeWlsNWlHdlFDaWhz?=
 =?utf-8?B?TTgrcTlyU1AvQzFUd3hvZXdVeEtGcjJiOHQ0THF1STNDQ1ZWRlBtSHJZR1Z4?=
 =?utf-8?B?dTBQSHlDZEppSlFiNlo5OEZVcVh3bE5KK2VoQU9mcWJXdXJmMlA3WjRmdEJF?=
 =?utf-8?B?UWRLTlFVQWxWcGlYcVZtbEJ6bVlHNTlQYWt2ZjJVQ3B5SFJYejhUYUdTRDhO?=
 =?utf-8?B?WmhyeUl3QWMzdlRyRDdiSXhHVmEycFNJZGxaSEQvOVYwNnVjbVk2UWxmWFFX?=
 =?utf-8?B?Skh4WHhYbUEwaDlSbkRpelVIZjBZZm5ub1RreHdQVnhkRC9GalhtV0Vkc2hZ?=
 =?utf-8?B?SDVIU0wxSFphSVVUSEIyM2tRbDIyRGhzK2ZnZzN2MFZqc056cWdjcDVBSXA1?=
 =?utf-8?B?eVdXWVJBakgwVEs3MjdyeW5PMTJOMFIyVkpDMGUybmlJT243NUxLY2E2N2Y3?=
 =?utf-8?B?dWEwNE1wbHkycDI2cWsvTEdDWG5acjhkMFJFQXBDb25VLzFqbCtJTWxTWTNX?=
 =?utf-8?B?VzRzdHRMRmRXU2Uya2NsRStSdjRROVVIakVMSXFJZHVVdmg3RjRNeDA4bmZR?=
 =?utf-8?Q?8QqiBat6WmoxNcS7ahCudK0Wu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XlJYf78UHH4CfNZJaQ5JobwZ5mgWe9tvT1600q1SqdH9REUXSVWiGBY6DT8dAfFLAFXDQP4V9mtRfrIVJPwyVkFAGZ/6lsIA+Lxwj1CQtA7uxkB7rSgB/iceyTnP8Ru+7dnVbmvRWtHjLsRD4bFfcEQLNPmEeB4afKl+FMR9UYkpoMxBniteeG7J/nV2bDzdmPviBlHa+wr7vQ+zwHWB+w7EDaXudsrnWtpK1uutIyXnozJg0eBGqR+o8N4QV/CzCMgRV5IPjvSB4NnZ7wSDfbZTqGJvOEV6GSmPjFyoioNhfip8LGNhe5INmXmZ45BkajQd1SSCij2v+kAKFbqxVTG6G/MtVYyOAWgzlSPzBWSgDp7Ok97t0mkHs098S6s6jwZqL7GL3bG9Q1JSfPajlh72BHMLZKw+VpUyho4TYP5dsS7kZ32P6+Gym8LO896csVo2KfGrYeiLriUi8UbfD+kxLAE3EJcycrwk7wA7I1srepAoFb8tGHOvFtsKMol+LG+4YfRjrYmEmg/gvbf1LXE/F7dw3IFwQH3wcFikqbDow2uEHppDdtZbOahJ5md/b9hcP/aRz8GeaomSakATGZLmq6HS6bNsRk4EfIKDuYI7PsRUzl8psXA2q5dPGUtM5ozA1AuETASQCS+jloskgyIwkqJDcf2h7yqt8y3+jApR2jefzKPrQxHzojorr6C6ljLuFij7Rq8Ol6jFGURmfPncETDHYWWtSnOAUacgeJfYq5mBxlOcLACVutgIJbQe5fqGQNYppWEmdfX50z8+Rw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e910f796-aa21-4afa-0f4e-08db203ba2dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 01:14:31.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bldvhzWz9gS8WL+7q4PvBfWUHUqh45SaswFjnJt4p4UkXNZAGmfyKTlCxI2SjaUpqLEUFgb5sq++WgIZ/6VTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090009
X-Proofpoint-GUID: CRqh1L3GI0lnesBCINncDShFnJpDfumH
X-Proofpoint-ORIG-GUID: CRqh1L3GI0lnesBCINncDShFnJpDfumH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/02/2023 22:31, Johannes Thumshirn wrote:
> Allow for RAID levels 0, 1 and 10 on zoned devices if the RAID stripe tree
> is used.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   common/fsfeatures.c   |  8 +++++
>   kernel-shared/ctree.h |  3 +-
>   kernel-shared/zoned.c | 35 ++++++++++++++++--
>   kernel-shared/zoned.h |  4 +--
>   mkfs/main.c           | 82 ++++++++++++++++++++++++++++++++++++++++---
>   5 files changed, 122 insertions(+), 10 deletions(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 169e47e92582..d18226f43d7c 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -195,6 +195,14 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(safe),
>   		VERSION_NULL(default),
>   		.desc		= "new extent tree format"
> +	} , {
> +		.name		= "raid-stripe-tree",
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
> +		.sysfs_name	= NULL,
> +		VERSION_NULL(compat),
> +		VERSION_NULL(safe),
> +		VERSION_NULL(default),
> +		.desc		= "raid stripe tree"
>   	},
>   #endif
>   	/* Keep this one last */
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index a9bb6eb39752..0fb5014d0696 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -560,7 +560,8 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
>   	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
>   	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
>   	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
> -	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
> +	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
> +	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE)
>   #else
>   #define BTRFS_FEATURE_INCOMPAT_SUPP			\
>   	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index a79fc6a5dbc3..4f07384817aa 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -795,7 +795,7 @@ out:
>   	return ret;
>   }
>   
> -bool zoned_profile_supported(u64 map_type)
> +bool zoned_profile_supported(u64 map_type, bool rst)
>   {
>   	bool data = (map_type & BTRFS_BLOCK_GROUP_DATA);
>   	u64 flags = (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
> @@ -804,9 +804,37 @@ bool zoned_profile_supported(u64 map_type)
>   	if (flags == 0)
>   		return true;
>   
> -	/* We can support DUP on metadata */
> +#if EXPERIMENTAL
> +	if (data) {
> +		if ((flags & BTRFS_BLOCK_GROUP_DUP) && rst)
> +			return true;
> +		/* Data RAID1 needs a raid-stripe-tree */
> +		if ((flags & BTRFS_BLOCK_GROUP_RAID1_MASK) && rst)
> +			return true;
> +		/* Data RAID0 needs a raid-stripe-tree */
> +		if ((flags & BTRFS_BLOCK_GROUP_RAID0) && rst)
> +			return true;
> +		/* Data RAID10 needs a raid-stripe-tree */
> +		if ((flags & BTRFS_BLOCK_GROUP_RAID10) && rst)
> +			return true;
> +	} else {

> +		/* We can support DUP on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_DUP)
> +			return true;
> +		/* We can support RAID1 on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_RAID1_MASK)
> +			return true;
> +		/* We can support RAID0 on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_RAID0)
> +			return true;
> +		/* We can support RAID10 on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_RAID10)
> +			return true;

Do we really require RST to support RAID1x, RAID0, and RAID10?
If not, we can potentially enable it separately from the RST
patchset to test its functionality.


> +	}
> +#else
>   	if (!data && (flags & BTRFS_BLOCK_GROUP_DUP))
>   		return true;
> +#endif
>   
>   	/* All other profiles are not supported yet */
>   	return false;
> @@ -923,7 +951,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
>   		}
>   	}
>   
> -	if (!zoned_profile_supported(map->type)) {
> +	if (!zoned_profile_supported(map->type,
> +					btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE))) {
>   		error("zoned: profile %s not yet supported",
>   		      btrfs_group_profile_str(map->type));
>   		ret = -EINVAL;
> diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
> index cc0d6b6f166d..c56788bcf07b 100644
> --- a/kernel-shared/zoned.h
> +++ b/kernel-shared/zoned.h
> @@ -132,7 +132,7 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
>   	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
>   }
>   
> -bool zoned_profile_supported(u64 map_type);
> +bool zoned_profile_supported(u64 map_type, bool rst);
>   int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
>   u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>   				 u64 hole_end, u64 num_bytes);
> @@ -213,7 +213,7 @@ static inline int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices)
>   	return 0;
>   }
>   
> -static inline bool zoned_profile_supported(u64 map_type)
> +static inline bool zoned_profile_supported(u64 map_type, bool rst)
>   {
>   	return false;
>   }
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f4ff2c58a81f..a8a370d1c4df 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -958,6 +958,38 @@ fail:
>   	return ret;
>   }
>   
> +static int setup_raid_stripe_tree_root(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_root *stripe_root;
> +	struct btrfs_key key = {
> +		.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID,
> +		.type = BTRFS_ROOT_ITEM_KEY,
> +	};
> +	int ret;
> +
> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	stripe_root = btrfs_create_tree(trans, fs_info, &key);
> +	if (IS_ERR(stripe_root))  {
> +		ret =  PTR_ERR(stripe_root);
> +		goto abort;
> +	}
> +	fs_info->stripe_root = stripe_root;
> +	add_root_to_dirty_list(stripe_root);
> +
> +	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +abort:
> +	btrfs_abort_transaction(trans, ret);
> +	return ret;
> +}
> +
>   /* Thread callback for device preparation */
>   static void *prepare_one_device(void *ctx)
>   {
> @@ -1356,10 +1388,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			exit(1);
>   		}
>   

> +#if !defined(EXPERIMENTAL)
>   		if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_RAID56) {
>   			error("cannot enable RAID5/6 in zoned mode");
>   			exit(1);
>   		}
> +#endif


 From my understanding of zoned_profile_supported() changes above,
it seems that RST does not currently support RAID56? If so, I am curious
as to why we are permitting RAID56 in zoned mode here if EXPERIMENTAL
is defined.


>   	}
>   
>   	if (btrfs_check_nodesize(nodesize, sectorsize, &features))
> @@ -1464,10 +1498,40 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	if (ret)
>   		goto error;
>   
> -	if (opt_zoned && (!zoned_profile_supported(BTRFS_BLOCK_GROUP_METADATA | metadata_profile) ||
> -		      !zoned_profile_supported(BTRFS_BLOCK_GROUP_DATA | data_profile))) {
> -		error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
> -		goto error;

> +#if EXPERIMENTAL
> +	if (opt_zoned && device_count) {
> +		switch (data_profile & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +		case BTRFS_BLOCK_GROUP_DUP:
> +		case BTRFS_BLOCK_GROUP_RAID1:
> +		case BTRFS_BLOCK_GROUP_RAID1C3:
> +		case BTRFS_BLOCK_GROUP_RAID1C4:
> +		case BTRFS_BLOCK_GROUP_RAID0:
> +		case BTRFS_BLOCK_GROUP_RAID10:
> +		case BTRFS_BLOCK_GROUP_RAID56_MASK:
> +			features.incompat_flags |=
> +				BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +#endif


This appears to be the primary control to activate RST.

It seems at other changes where "#if EXPERIMENTAL" is used, it may be
unnecessary. Instead, it would be better to enable the code anyway to
test with BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE unset. Where possible.

> +
> +	if (opt_zoned) {
> +		u64 metadata = BTRFS_BLOCK_GROUP_METADATA | metadata_profile;
> +		u64 data = BTRFS_BLOCK_GROUP_DATA | data_profile;

> +#if EXPERIMENTAL
> +		bool rst = features.incompat_flags &
> +			BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE;
> +#else
> +		bool rst = false;
> +#endif


For example:
We can remove the #if EXPERIMENTAL and delete the else part here,
that is

bool rst = features.incompat_flags &
			BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE;

because BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE will not be set unless
EXPERIMENTAL is enabled.


Thanks, Anand

> +
> +		if (!zoned_profile_supported(metadata, rst) ||
> +		    !zoned_profile_supported(data, rst)) {
> +			error("zoned mode does not yet support RAID/DUP profiles, please specify '-d single -m single' manually");
> +			goto error;
> +		}
>   	}
>   
>   	t_prepare = calloc(device_count, sizeof(*t_prepare));
> @@ -1755,6 +1819,16 @@ raid_groups:
>   			goto out;
>   		}
>   	}
> +	if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE) {
> +		ret = setup_raid_stripe_tree_root(fs_info);
> +		if (ret < 0) {
> +			error("failed to initialize raid-stripe-tree: %d (%m)",
> +			      ret);
> +			goto out;
> +		}
> +	}
> +
> +
>   	if (bconf.verbose) {
>   		char features_buf[BTRFS_FEATURE_STRING_BUF_SIZE];
>   

