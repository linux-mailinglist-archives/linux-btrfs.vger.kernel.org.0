Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E85780724
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356897AbjHRI2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 04:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjHRI2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 04:28:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821222684
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 01:28:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I61e2O009365;
        Fri, 18 Aug 2023 08:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Pv94Gltb2YDEx11wltISCftvIUDxv2y8gaRS2hVq22E=;
 b=i20QcsqO+x1TWk5HsZtGgtsdZ85SWb8JEMXa2gbRG8kxSLvSfn4DjO8MSMZI0m936DKc
 ay2rTdXbKQ4w1pnH8f+TQfEzUEEVp/I5CiGSsGB3BhszBXM/v5jyJnyTBw6snkVOsl55
 US00hVZeW1NCCpwmcqtgIwZwZKygw5jdLNA9yr4J5Yz3HO0SbokTh16zeJenv6k1QScI
 E+UCEvernLBDR68SgKcCx9D89Fk7CrleQHFPTIZjOoZO+Qbcsfgv8OjQGhc8xHDEmtUt
 KY9W3WYG/+JifKBnrHmhLCJZgWPomBC9usVtjDTWeyzK9XLiwo0SjVK9WELjttdQoakv Pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfu7wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 08:28:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37I7xdjs019981;
        Fri, 18 Aug 2023 08:28:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey405n6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 08:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaEEFjGRpiHKpgVkphDQebrD5hqYw6N+tojT2Sstvw5NDk4d2+aqAU5MnfBUFLhAf7Ss67qQ0pGh5L5ddgeno8nl0o8weTxRuznRijxgcLHqbrE3zsKo9MvpPD0Jy8+yulCmZevgDTd+CcdzaIq5bsMaH1QxCYn2tepqyvLM7VVTLWBwstzsVJXhZg/GjqwJ+DfclcDPdr4hYYKGzPZF2hDQvBnOOaLf17xQPhsaWfIbJl7V50hJ9VDuT6IabeB8GgDEGCY1pAbLgHLbveGBRhNXhWuUw5y2fixt07l1FFLljPGUCtbAX9kXjRiAK9WWp6LKeNCoZ0LvgpULzQjnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv94Gltb2YDEx11wltISCftvIUDxv2y8gaRS2hVq22E=;
 b=eAGBW/JiHAMLPq4XXBKaso7k8OZjSOdzRfrMiLWABCxaCUGpSifgMlC2Llj1e19lGpRDbxuclMrSY9UPfCWZuWh6AoEcycfXLZ/2zBAAEFM8jloq/HtoDsBwoiG4LMAEcKBrXtb45reL+phOxJALTU2njhXCYo/YyPvpHfPB5FbMSNo6MKwzhOh2DwcC70ZfHQW75/bx9LvmoSK1kkcscfkt9aScKcZVhLqFab0YFZXj1m6uY1McIDpcVZxxRYRvCSJ/9NvouOsnIRljG9iyf5Yt49P83CFhFzINuUQeBkDJkIx3v2a9ZRBF18DdJD+Cb97hwFkLDG6flGWTgLkoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv94Gltb2YDEx11wltISCftvIUDxv2y8gaRS2hVq22E=;
 b=knxfPAzAp4PClFVykwNlt1KBQUyJ81jzEfDU/LYm5ubPirSbM6HBMmgrNWDFE6LVihq8PhsWrzu+vYwaQzWBdr6Krtis7d2Bvad+zXoLiXCc5AJLj0EO5O9tyFZE/kFsvK8PaiKo5fR1e4PXflm34p353pnY+pk/gTVA/fZaAp4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6280.namprd10.prod.outlook.com (2603:10b6:8:bb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 08:28:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Fri, 18 Aug 2023
 08:28:05 +0000
Message-ID: <f45f036b-72df-1ec6-ac32-4a2b98be5b3a@oracle.com>
Date:   Fri, 18 Aug 2023 16:27:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: reject device with CHANGING_FSID_V2
To:     Qu Wenruo <wqu@suse.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
 <20230817120424.GK2420@twin.jikos.cz>
 <25703f72-c647-d8f7-a150-fb7c66842fc0@oracle.com>
 <5fafa142-7995-4603-a6b2-8360dda8e7fb@suse.com>
Content-Language: en-US
In-Reply-To: <5fafa142-7995-4603-a6b2-8360dda8e7fb@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 823c40e3-4cb8-4fd1-9ead-08db9fc50b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFVi/YGFfjUFBcS82RplXNo/1z8WMSvSx27xj6vUKT7glqJFDCQesj48CSZ9GHOvAIuGaBd8CH3W6NtCI0QKmzb7ZbBKE4/CouUqNK+npHH41/AMsDF5YJcGuxERNCG17shAPDBl74YTekK2MtTmSD2MlgVxij1BC3rGQfN7VT04bVoCmrA2pZjAzod+hRj+89+OE43OdkFK9j7vtQmGn35h6aBCl11KXV8CLI3p7nSNg4+S5goD3q9e8J1mQNXRc1HRebwhaEROobxKmk+uWMjvu5ebttqfb6177p9ni5Lk4viFT/F3xB1u5xUlnZ9TxZLU6EvIbveMfcymQL/OT7cXzEJK0TBpW8tjWmb/ar6ueebo7Pe4bYGhqarNsUb0GdLAY3Z73UwIXYCWiWJPvK2sSpuxtHETbEV/YuNmwKo1AZo37bfukLxDAnU2pyWMHE+akhrPWC20rrsAKDuLNqDOuW6VX7XDFpdEuLLw6UbcLgjHfnssc+yjmkRE3MujbNv3iukWhIC221l4rH6SVxFXlyndSR9WMOMeXQgUOZ4n3vKcNQ1NcWKIVS17Daus+LCRruMREYHdWoskO/aN46wzxTsOwyV6bSZ7UD0sn+B1kMXVpxOZ75uC+8OtRhd7EC81VEW2IjPcxQ8ol1ZTyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(86362001)(31696002)(66899024)(26005)(83380400001)(36756003)(2616005)(2906002)(66946007)(66476007)(66556008)(316002)(41300700001)(44832011)(5660300002)(31686004)(8676002)(4326008)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VLZy9RbnZUQkdzZ3NNM0hMMkt6aUxPUk9nREZPbEVQQ2tQVS96YWhHelZC?=
 =?utf-8?B?d1o2d3NBRVp2VGtqQjYxZGlYdHo1bGFneWVoUmZzcXovREY5aFdyeGNGYjhT?=
 =?utf-8?B?cGpGYUZBd3BBTUptMk9vVzRuR2pXR1UyTWlhZFIwaEVCMGY1eFhNcTI0c1F1?=
 =?utf-8?B?dWlDWU52dzNZSFNaRnBFeiszK3dQVUV6OU9kYlJWZVNYN0V6OFBoRER6T0Q3?=
 =?utf-8?B?eWdxUytKUUlxa0VaSzZtbUVuVGhBWDB3V25ocy9vL2duOFo1bkFUWWtVamt1?=
 =?utf-8?B?QS9qRUtLUXhwdWxxeGd5alZpUXlib1lqTVlnVjZtRks2bG8zTHdoUzNXTmxD?=
 =?utf-8?B?M2RuSCtwT3Rhb1cwbS9jZ1NyNFp4c3BWVHEvR0tDT0JRTVhmTjk2SkozMTF4?=
 =?utf-8?B?M0U5WDl1NXZ1aFZyL0pSdVE3eWVmQ0lPZ29QRGdySUZ0eVZqbGhGcHdoc25M?=
 =?utf-8?B?anVMTGprZ2dUdWYrRHhxdXlYSlZ5RE9WSTBEaFVjOFpzei9maEUxN0MrazJZ?=
 =?utf-8?B?b3RaOUFIcDdXY3ZIdnBESzY1dkc1a2t1UlMya2pTRTg1RUdUdGhOaEU4RmFU?=
 =?utf-8?B?K3c5Uk5tRnllNWFNaVhDaUs2S2pldDh5dGFyOFY0YWJkVy9md0EyMHR3VzlV?=
 =?utf-8?B?WGhWc2NBdW9MR2d4Vk9lSkwxS2lVWnpEYmNaamhRdmFIL0JuajdNSWt5NGVZ?=
 =?utf-8?B?Y0hJRnZuaEFtdTFKbHh0dE9kWUQ2eC9pQWRNdzF6TTI1Vk1IejlBb1NaNnJF?=
 =?utf-8?B?UDk4MzlaWlVYR0hDZ1hLVHJ0bVgxRC9GanZEUHRicktIUDdySHg1UmVkWThr?=
 =?utf-8?B?TDZza2R5VTZnL2o4SXpLcE1BcHFvUWNqSzU2V0lmZzNJbmZGNGZyd2owSDlo?=
 =?utf-8?B?dEtncWdnL3RXcmJHSW1ZS0ExNjdGVHV1OXk5ZWJmRUZXUGdoMDBTTDlkSnNi?=
 =?utf-8?B?UExHUUNpR24rbThKYXVpWVBCdmxJMjd4cWFSTC80WE9udWRXRmtOMEVEYzJH?=
 =?utf-8?B?d3RhamRQcnVmTUc4UWlaK05kZWJPQ1pQMFhMaFNqN1VibDRESEhQZmRNL0F6?=
 =?utf-8?B?WDRaOFhCRERyUzVRUlYyemkzdVI1alZnNHNkSFI2ZmovWGI1L2JvMkFDUnk3?=
 =?utf-8?B?bmtlaDlUY3h6d2FrUzU0SlU3N3V0MEZNL2Iwd0FFRDhJRGJlMHE2all5bHdB?=
 =?utf-8?B?WVREMnZzQ2ZUS0RTWVZGc2ZLdDhjZ0t3Z2RpMXBHRkQwbjBvTDNyVnRjNTBS?=
 =?utf-8?B?Z05CMFlPUmwyc0xrckk4OTB2WTdROUJzZS85RlZuMEVXb3Y4M2VUeCtUUFg4?=
 =?utf-8?B?K2xvTUhuNmxnYXkvbjRRSTZ6emszdXMzOUYvSHdCSXFYSVZpeWF1L0NoV1hS?=
 =?utf-8?B?MFZaZjRXayt0RlZPVmhNdmJhaGFISUFnbmZ4VVhlSGJiZUFja3N0NmVkeENx?=
 =?utf-8?B?K3BjMVpwdE9yalNXL2RQRFRCbHE4QnpkZXBUa0pkc2VFbXNQcEVIdlQ2Uzlx?=
 =?utf-8?B?MC9EMXdCcU5hTlRuMWtlWlZYSG1mQXJOUmJ1djVhNmRoZm56amZmNnJyYzNY?=
 =?utf-8?B?K05KbmhqRkU3cllXbzVRTlk4dDVpdFhJem9OK3JKWWpnaXJvK1FiZWVtNmVY?=
 =?utf-8?B?T0J1dDBFcjRpNmtSOURBNHJlNlBYbS9nQUtTVGl0NC9xdTNkaytLdlJvWndG?=
 =?utf-8?B?aEZvbkQyUzVsN1hKK3p0WFFWUG5SM1VrbWZDT2sveHdZdllJRmxxN1c1dVBw?=
 =?utf-8?B?SjgxOGswcGw2OGNLSkxOMCs5OE1yRTFIc281bFdNZDMydEFjT0IvOWxqY3Ix?=
 =?utf-8?B?S0NTVkZBaGdodjZlVFkzaWZZTFpyWjUyUGtHL0JpSFJlcTUxbW5UMk1EMWto?=
 =?utf-8?B?YWdTTVZQeUI0aERtM2V3L1BsTFZEV3lNejh3WUs5L3BBTzFvVVVVbFNGMXFS?=
 =?utf-8?B?aGRuWTlqTDd3MWZJOFJ1dG1ORlcyWWVCSDd1RVFOSThOcXNIVThiN2tNVlJL?=
 =?utf-8?B?NnN0bFZ1eWo4RTFNa3RDejdEMjFkN1FMcVNtMDR0WS9IbGNOWEE0Mk5uQ1ZK?=
 =?utf-8?B?elZ2dUdubVhjMzFZaGd3Z1VMbGY1S0tad3dTWVdPNnJRZnZFL3pRMXpsQUpU?=
 =?utf-8?B?VGRRcXFreXB0L21BamI3TGdJS1pjeFBWdjZHQXdnR3VNNTUrdE8zMnJjTFl2?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YbnKtY1HzjbStqSX0FKB4/3x6fPfOivT2kbtIwqhD8U42hNIzFu1nu14IpdO4R1fC07UiMTQOfEPuSx/4xKx8cYynKg8wLsqTcf3nufjqzrNjC2zxpSsHVhRWdveGULXBOS+uT007sDl4zjM9JjtW/a00bNR0ftmH2qeFbsz0Tjpsz9AVqgoxWU2oLOhOCV1QHyqPKE4oFZ3TkwCgTaPn4BJ3FDUo7msut+doz7vTK+kfcO8B8m4Yz9cDCoqjKCcYjh+CUPqmTGw4CSac/T9bFB0b2fsrHnbHzMOvTNBN+cV/ieptguVGVkkTDXGXteiET6SVDkfuW7Ys0zkR4LpEbo++Cxx7jUB4UUXznVcHy2kv4AOaWdCtuHGizgfi/4CUmJ71qkbDUYePKuh2uz6AUJebOZqQmfaFVxEa+N/1aiNoDVDfMhxBPinqYOyKFPf0f+t3gyQSHkWsNSU+xAlPMeboC1dINZeQsReYhhEICWpp3QoR9ClQnBkD0e4SBAePYhIKzaRBv/rPNag721xc9mSnKtc0gLi4JLq2Qhb29mK2Yth/miDzNIQqI37Wt20QmzzGK+X/PXDIPZyLhHuzRQDcQj/0IGFaPXSpy/P8V7IlkoVTxUwTbUw0kMYQlsMwY6749J77XNXdurO+eH/DsAmUhIajiSAs8NmBndeAU2uxyH+lGoFlJvSI/yn1x7w5UGFOHzIjQhEa9chJI4PCqMJyWNL4gNwuYq1q/1augeNoYaWta6/Atsdg4wYAKmJUsTHtELg28gTmAdwYCj9dhPajff13pc8yttKWy1lVgj9twsrDJrX7/dS+06QyJmv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823c40e3-4cb8-4fd1-9ead-08db9fc50b38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:28:05.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: varZUOXgr86eYpQKg0hNBC7vU4MkXtyJ3tEWiUps8pvCwjtCjjmZFtPBXidLyo7AvD6crKV0419PqlWKybFLPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180078
X-Proofpoint-ORIG-GUID: hpx8wN9lZR566gstD3En8jbDJtDMreq6
X-Proofpoint-GUID: hpx8wN9lZR566gstD3En8jbDJtDMreq6
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/08/2023 08:21, Qu Wenruo wrote:
> 
> 
> On 2023/8/18 01:19, Anand Jain wrote:
>>
>>
>> On 17/8/23 20:04, David Sterba wrote:
>>> On Wed, Aug 16, 2023 at 08:30:40PM +0800, Anand Jain wrote:
>>>> The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
>>>> where the device in the userspace btrfstune -m|-M operation failed to
>>>> complete changing the fsid.
>>>>
>>>> This flag makes the kernel to automatically determine the other
>>>> partner devices to which a given device can be associated, based on the
>>>> fsid, metadata_uuid and generation values.
>>>>
>>>> btrfstune -m|M feature is especially useful in virtual cloud setups, 
>>>> where
>>>> compute instances (disk images) are quickly copied, fsid changed, and
>>>> launched. Given numerous disk images with the same metadata_uuid but
>>>> different fsid, there's no clear way a device can be correctly 
>>>> assembled
>>>> with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
>>>> disk could be assembled incorrectly, as in the example below:
>>>>
>>>> Before this patch:
>>>>
>>>> Consider the following two filesystems:
>>>>     /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the 
>>>> btrsftune -m
>>>> operation fails.
>>>>
>>>> In this scenario, as the /dev/loop0's fsid change is interrupted, 
>>>> and the
>>>> CHANGING_FSID_V2 flag is set as shown below.
>>>>
>>>>    $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"
>>>>
>>>>    $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
>>>>    superblock: bytenr=65536, device=/dev/loop0
>>>>    flags            0x1000000001
>>>>    fsid            7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>>    generation        9
>>>>    num_devices        2
>>>>    incompat_flags    0x741
>>>>    dev_item.devid    1
>>>>
>>>>    $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
>>>>    superblock: bytenr=65536, device=/dev/loop1
>>>>    flags            0x1
>>>>    fsid            11d2af4d-1b71-45a9-83f6-f2100766939d
>>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>>    generation        10
>>>>    num_devices        2
>>>>    incompat_flags    0x741
>>>>    dev_item.devid    2
>>>>
>>>>    $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
>>>>    superblock: bytenr=65536, device=/dev/loop2
>>>>    flags            0x1
>>>>    fsid            7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>>    generation        8
>>>>    num_devices        2
>>>>    incompat_flags    0x741
>>>>    dev_item.devid    1
>>>>
>>>>    $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
>>>>    superblock: bytenr=65536, device=/dev/loop3
>>>>    flags            0x1
>>>>    fsid            7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>>    generation        8
>>>>    num_devices        2
>>>>    incompat_flags    0x741
>>>>    dev_item.devid    2
>>>>
>>>>
>>>> It is normal that some devices aren't instantly discovered during
>>>> system boot or iSCSI discovery. The controlled scan below demonstrates
>>>> this.
>>>>
>>>>    $ btrfs device scan --forget
>>>>    $ btrfs device scan /dev/loop0
>>>>    Scanning for btrfs filesystems on '/dev/loop0'
>>>>    $ mount /dev/loop3 /btrfs
>>>>    $ btrfs filesystem show -m
>>>>    Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>>     Total devices 2 FS bytes used 144.00KiB
>>>>     devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
>>>>     devid    2 size 300.00MiB used 40.00MiB path /dev/loop3
>>>>
>>>> /dev/loop0 and /dev/loop3 are incorrectly partnered.
>>>>
>>>> This kernel patch removes functions and code connected to the
>>>> CHANGING_FSID_V2 flag.
>>>
>>> I didn't have a closer look but it seems you're removing all the logic
>>> to make the metadata uuid robust and usable in case of interrupted
>>> conversion, while finding another case where it does not work as you
>>> expect. With this it would be change in behaviour, we need to check
>>> the original use case. IIRC as the metadata uuid change is lightweight
>>> we want to try harder to deal with the easy errors instead of rejecting
>>> the filesystem mount.
>>
>> Robust indeed. Silently assembling wrong devices-data loss risk?
>> Failing to assemble is still safe.
>>
>> I think it is better to introduce a sub-command to clone btrfs
>> filesystem with a new device-uuid and same fsid (as it looks like
>> same fsid has some use case).
>>
>> Thanks, Anand
> 
> Oh, my memory comes back, the original design for the two stage 
> commitment is to avoid split brain cases when one device is committed 
> with the new flag, while the remaining one doesn't.
> 
> With the extra stage, even if at stage 1 or 2 the transaction is 
> interrupted and only one device got the new flag, it can help us to 
> locate the stage and recover.

As this comment is about the btrfstune patch

  [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit

Let's discuss it there.

Thanks.


