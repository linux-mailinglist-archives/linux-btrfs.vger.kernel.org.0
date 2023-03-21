Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E76C320F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCUMwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUMwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:52:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F0E17160
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:52:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiFgJ012418;
        Tue, 21 Mar 2023 12:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=qLA8QYEKYIkbsScYiHV3SEwi4tQKcI7A+kaugMlILr1oDd/BRaAPdNzcqsYrk5KOybP/
 9edUFUaeMA2yyiwT6h96webUGOpit7wgRFL4GDV1hS+B+1w5vhTx1tMcQUYPidpQYV+L
 pOrbqKzTBT9DJP1S1ektu8dO74o+ZMuNl1gQFTBZ0b5xwBVhIxtKxTOZlJa3qsUgo/Yj
 CLZaiDaPjsWJFGACLsFkmX7KcIvDga5VhHvmVIrWG538JZvE4DhAZEg6R2ME8MX3uXYL
 zPipBfjo7oG0w0Ns2O7nq3y+H+izLJDYGtcOhLg20fMBr7SulxU4F/6KUaSvih4bZgkq +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt63nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 12:52:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LC2ITs038614;
        Tue, 21 Mar 2023 12:52:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rd5sk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 12:52:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjChQYqyTK2l4GtlbqR8NdOIcgtsFOfCor4WX5FdE5Cei41DwET0Z9mrcMC/T348+EUFJhXnruGVdFKqOP8ifpiP9r1iL/+y0XCztErCWX4GQ3fkmtddw7dBKVm8rl6suOruXarfGIiEotOMDsx1DYjBQlmitpXIyuzeJrbuQknBSVLbWsVHYhWD9ze5GsoK9DlbL2j7n7OiQyD/43sKa3MGYIea97A1seQyvnxeRPvpRp3DB4gQ9+mvl27s2zQ4GLiiW6iA8mrnW32HqDUSz0k/T4W4c3tdfiZo6ljZMyQWkA+dN+6m1qPJITSRtVQnMBUOheNSU9B2HIgrr3+SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=fmtLJdtFh55FliUH6Kwt2iRYtZFa7+5FQdW1ugV8xqukXAl1NhbYSd2w8+UiiDcFvzPcfuiPb27Xp6lFKBzOqXk4+xRolY6kFNvaALRyqBw3k7qHjFzAgxsc03vwOxEn+RS+7aSZ5uUBqVU92w4uHswnmjFal2yqAI/iLPdvzE9l3DS9J5M2mWs+Isbdhs43P7fgDr7pOMZzzONt/2vWh86eZtZdbhiDwTNsY8GbldbRhTd266+QCuH9DZbvB9QbTr2RIGH9iREEOWK5eSbM7b4lhg171SRxzKLMw5v9ta8BQDrh94fj8qvI2tI2dbDsfx48UfOMGxQvG/Ao5R/ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=otCL5XfIUufqky71PavNwSF2CSAHO3ByFGpRIkRE85Vy69GaxThpZxsosRFDS9uCCQtGVRj/aV/HRCnC2xZZNtLfn2l455CyHAvT+0tg8bIsvsnYXefdDg3t+P+E138jrOFJdSGwJYfMFrewYZDTgSYoU3qUEQYOj8LdaCaEh4o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6910.namprd10.prod.outlook.com (2603:10b6:8:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:52:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:52:45 +0000
Message-ID: <042964fd-576c-c455-c8a0-33813f86037f@oracle.com>
Date:   Tue, 21 Mar 2023 20:52:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 07/24] btrfs: simplify
 btrfs_should_throttle_delayed_refs()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <5c0f23a3f7c8fe4c3c6fde9c1d0f4baa80babbfd.1679326431.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5c0f23a3f7c8fe4c3c6fde9c1d0f4baa80babbfd.1679326431.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: b677ac3f-2782-4c8f-637c-08db2a0b2a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zN+by9S0cksSMuXnqvYOBvptRnubuK7WpjPagK6ZkDUaN7qd4/k01lVo4xgsEY3+jYhCXJoJjR4pOUF3KtOLveQ+jLTodjA9JaWeHjiU2byXNaNOOiC8gSMuOHTWpqFZTfXQq/E0Juc+DwRQdmg2PHtTOrj9931ef+VOEABnndjpam+C0f69C4lBLl1XHE0E1QPk+OYZe666lHPNfjY+7FgGRIa6Of1y4a/BXvwHOHBdIoAckrN4BvtKg+6Lmyvy8QPG4RYMWBo60aNzwu0hzcbp/AG+CbwfbannksnizoRCzOv9e3wJVlr94Zn90DFom0rNp9h2z82+vXRtQRxSS+AmCzz1A4mwpjOx1xc9ylsoNjwi0xso57rkL1zRTshoeRjgL1ZaBbR9ZWY6+69jbBes+G8hqM7JmuukCxDnp1KBurLT5mkd/BHk6QJSGoMV2oHVqYg09ypXwFvmCU0G7lFpQLfVyRjkGjZrtaysaKL+meYNxTRoQPcSqSi2qXBodwQcp9hIue7quFfzC9n+ILEE5MH49rOTxIhOO8oQa58cvt4yJ0uuEZFL81YHo1cqTwr8b/puXrogbuoQGvDxEPYaaP7m8KXgKT6FynJbyROeh4IptrTJe5Tnm9MhOmtJiRHafvn3l++wcIybzXw98C+ud134ucrxJejdPE+1tW8V4fNZ8q5Q1rpXwTwjrugbM9REdwt4rdHOvqXThgxXfJWakSWJJ/IY1VQ5tq9Ou8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(4270600006)(31686004)(2616005)(6666004)(6486002)(6506007)(186003)(6512007)(26005)(86362001)(31696002)(19618925003)(38100700002)(2906002)(558084003)(44832011)(316002)(8936002)(66476007)(5660300002)(478600001)(8676002)(66556008)(41300700001)(36756003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVKMitnR1ZRWGplUWlrK1B6N2JlZi9PUWJnWkJ2YjNHeUhvMTVZNlFDTm5G?=
 =?utf-8?B?alIzU092bncreXY3WDVBbGxRVnNVU1NqeWRqYWJsRFJXQTZVYzFmSk1VREEv?=
 =?utf-8?B?N2VMRmJicVZ0WXdUSHVMYXdNRGxqOC9mYWY3SGFCWUlsSkdJTE1oeng3NFRm?=
 =?utf-8?B?Vnlsa1Bvb2dYdWtOT05XaWtMTGVMeW9jR2lCQkdVaE5yUzh5WEpBdTEvbVVy?=
 =?utf-8?B?dEdWc2VuZ200NE44aUE5YWFERXRMSHVFam4zemtZS0o4bVpTNWNPcVVVNWhX?=
 =?utf-8?B?TkZ1WVpDelRrc3ZublRtV29KMGRuM1NtakJ2RTNBRGZ2d2Z6MkxoeGxtdVJs?=
 =?utf-8?B?cllIaTNNYUpGNEZjdkgrNmJEYk9UZ1FKSFN2SFZsd1Z5Mmtsdm1ZOEhHb2Ny?=
 =?utf-8?B?VEJuYU5PTkRXVE1qT200MXFQMlRyYXVWc0xqYXdsbmtUVHRUTGJjUWE5WTJw?=
 =?utf-8?B?Y2FpK2ZCOGZqY2ZYdE9XZDFjOW5KK1gzUjliODhac2lYSllBR3loVFpDZHF6?=
 =?utf-8?B?YVhZbEVjTk5Pa2k5Q0NpaUNnQ3hSdFdJWmk0aTBpU2V0UWljakxVMG5DL3JG?=
 =?utf-8?B?YjlJOWd5Yk1nRDZReDdoTjQ0amNOdWxJaVpUUlhxVGZ2VjRjT1h5QVNuMFor?=
 =?utf-8?B?UDZGQTFTY2RvYzN6N0VINDFMMDZNbWpRL2IrUkVVQjVNbE1MWjVmTzVINVN3?=
 =?utf-8?B?TnpEN1h1N2VYd1d0OUxKYjFiaUpmM3dsVlV5UWx4bWFvNVN6bGVtajBSV1Nx?=
 =?utf-8?B?bXFlSmlzSG40TzI2bGlqQXMySEFpak5raTA1WVZOS09lcW1OdWM5T2h4elFY?=
 =?utf-8?B?cU5VR2JrbDJ5YzJPTzU5czRnc3pWbHZFcHg2dWpmMXNQYlBYT3owd1FsWm1y?=
 =?utf-8?B?UlJaVXdYaEVuT0I2Q0pXaDBrMEFvdFk2RGNXd2ozam50UWdVK0lxTUJyeHhu?=
 =?utf-8?B?QnBLQUt0KzcxL3pkVUNaK0ErK21SV1ZFSEtYN1hMTUw2VUg4MFVYb25vcVBF?=
 =?utf-8?B?TnlSYmFqeUVrcTdFR0g0dEVOVFZNY3lVcUhyQ0IxWlVDSnJnMjU4WHdudEZ1?=
 =?utf-8?B?dHJ1Wkd4Q2VuQ0oxMWwvR1lyS0ZPaFU0V0F2NHlIUnk2eFpWSUlML1ZwOGVV?=
 =?utf-8?B?cUFTTlB3YzVVajdXREJmSFpzak1rSVBUVCtobmtmOXMwQW00WGwvQzczckxr?=
 =?utf-8?B?Q3dDZHdHT0R0bEEwRmhqelVEWUJFWTMxT3hRWjdaUWhOTnlKd1M3OUczcmEz?=
 =?utf-8?B?ajZxQ1FLb2pzM0lMYmlaWVN1UVhUYys3L0FHL2tHeXM2L0VrVTRVUzZlZXg2?=
 =?utf-8?B?U053aThPY0RJZmFRZXBKeGxLTUJtUGZWUUdWY0hXbGVRbXdJN0dwd1FOMWpE?=
 =?utf-8?B?czVRLzBPMVI5Z0s3SW4xUzdIYTNPNGFSTVl2b1luQUNxR3NQaEVRL0NmMXBa?=
 =?utf-8?B?bEVHYjY0RVRBdFBzV3dGWFltVmh4Q1duRi81NVZvVFBpajRRaGdLNzZ4OS9O?=
 =?utf-8?B?NEJXTVFjM2hSMjNzMnk1bHhwSnJ6YXovR1hUaWQvdEdQckFUMGdXRWlnMisv?=
 =?utf-8?B?Qm44eGwvWk9ZaFoxOGZ6T0duN09HVlN1VUFacUEza1NWVld6czRLUUYwSnM4?=
 =?utf-8?B?WjhudWtDZThqNWFUaHUzcWZkM2FGanZqcVFMOXZac2V2cnhBTFovT3BLd0tW?=
 =?utf-8?B?OC81ck1YcU93T25oSWIwRzVoNUpPdjlOUXM5QjJaVWxVdmtnZ2R6cEVsdkRL?=
 =?utf-8?B?MVJRVWdBRjhXbWlBS09PSm5nQ0Z6YWwwWHIzNU56cVJ6Tk1MdkRnTVUxK2xD?=
 =?utf-8?B?MkY3Qms1RDR0b2hNTGh6dDZoT3FJQ1dud2dheDY2RlYyeTZtOUFrMTNmcld2?=
 =?utf-8?B?dkpJeHpzV1hZdXZVVzFqQ0pWZXRScWdRZHAxazBTdEt3dGtuNHlVMHRlTVNC?=
 =?utf-8?B?TmEvUU5BZXJiS3lUdVJjcHpKZFVXTVZ0MWZlTE9sVmxaTEEySktSbEh5YWh3?=
 =?utf-8?B?N3VNUFRqTXgySnMzeUpZUUs2OXlLcUNqLy9mSzROM1VkTEphWkVWK3gyTTVB?=
 =?utf-8?B?aTh5WTVxc09OVnZQM0ZGQ3NPb1VTeDVnT1hnODNPbG1mc21aY3l4MXpTQ3RT?=
 =?utf-8?Q?MWItC0NCxBj65yINXcM93orPE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cmisx3cMk1Hl+Lt3tRqCXKb6cU8LaF1STl9AcvlD1ZwJdmuJP6KSSeWd5QhWgnsKi7/A+81SUszfEhogmVnVX78wL84TkgqVAMe/JUGKel/rft3ENtcMSPtGTR4a49WH4nMysQHP4jfztNMlA3VKSj1jBW/m3bberf205oeh9Ra6wTK4cPwQjBXZh6qH1i54X1WhMYwrTbGCbD93ZNzraBy5wXLVRgninEG/pVnNdYFYyaOwIZyRvDbeH7P68qtyBueJaE1UgiM8dds1vcLKD4cTde7RsqH2eCkpHCKxwXMHVfit6miOIIfAR/VmDyFweXuaymzfNPEcO/t9qqrgmNOa7P1JsoWbq4AhCSEOeh1Y1DWusaYRn0fO4yKr/hFhaccL8nxoGnG79dYI+2gshE6p7t94Rkoi3y2lnvkUoOgxs3GF522VAnDu+9NjJldFm2zFfyUAoQ75ob40Pcfm9OulonEEU2AnSZsMcbV53qqymM/+XP73iJnj/xEiaHwK6tnOCLhSjCVu10jEktWW9w3CkTPSFS+GsOggd+GNxcwfkcVtzg7xYLtbIbRyezgb71cxoPoP+It1w7tZIW01c4xxW5tpjaKANqQMPAOj9QmgPyKmlga2qkun0egIIhDLHgtyGjOMflvPtbjjulwknpsqm4k0hE5VV4tSyvxX3qclxEFyqtnXC364xet2ZRmPxuS5lZjGjI7LGjepHT3Y/He3ibAJdfKolOKq7KBrZ7BL0X/BjYZ3jA0l2P1dk+gnXVsESUpUdDMLCr9wPQ2MDRHI6r6jBWhISt+ZchdIiJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b677ac3f-2782-4c8f-637c-08db2a0b2a7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:52:45.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWZEQ05Fw4huYk+Pe0jq+LVzeT0sEIYMocSgcxPsSWlsFMF9RAxsGUlY2J1TQPx2j/5IEoYt/sX0qSWki1Dd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210101
X-Proofpoint-GUID: PPldVsKSQHZOamgGTIzPp_-1ggBcm3ra
X-Proofpoint-ORIG-GUID: PPldVsKSQHZOamgGTIzPp_-1ggBcm3ra
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
