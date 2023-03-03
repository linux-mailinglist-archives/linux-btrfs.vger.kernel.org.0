Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4446A9386
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCCJPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCCJP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:15:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA441633D
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:15:28 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233hxaj004604;
        Fri, 3 Mar 2023 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pQJPdPvhN098zi7dGHXazMoXv8c4J80gFbgCTSny83w=;
 b=cjhcn8B6Y0/EuZtvZfm9l0oTOtkyY9WiU4AqR5OdvypLQTUcup0ApYp6wrpfyofpPk8k
 zacaJhZOE1JATemIdgeTZopRAxU7r/C+fCUxrDRI05Ai0pksNwkU42ie53hx1sKUFds4
 U/u739NJ3iolamcis9JQ+NXycgL5l+6I9ucHNyT+FB+g3DTXij53V9mgm/ZLOdxRUnBp
 k1u1mOLNZSrA3SD4Z+PT4nZB+zxNIjettDAIpCqUOLmOA4Ty6rQqwaCqGOej/6nA5ejI
 sVhe2v4gB2ji/0rXa4l1P/gA/tHMrY0Aylvsm2McfQNMEVdVWpaiV1RUfY9xPhdr1N5B 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6enug7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3237HCZO033014;
        Fri, 3 Mar 2023 09:15:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sb7xw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyhAhALEMoyLeV1LKeZUghtPDpmh0xNm+YFYdBxBJR3/kAtcYmfeCPqQ7ZSHb+mVxWJzxtfGioIPjDpJrh7jFah0/clKhQb/bMw8mhNFck1zW0lqzpeNTjA4gTj8YlEOa66GKGM2J4ilcu48B2HdA9nwMuGd0A/fvVg4lvJIrxItUpu9NUUiPLDS8Q9kWJ/8L1SHw9gye6MgRz5pKTB3AvU3nAi1brMad6MTh8IdDkkfo0UFsN4XlGeD7rUmXt4YZQfF4r3vhU3Rl3/wcCu0hvDSnmtcnzsKbnGLnUJeHm5bL32UFSQbbFEc6uBQO0emzbiy8rvrFqtpaY0Xh5nE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQJPdPvhN098zi7dGHXazMoXv8c4J80gFbgCTSny83w=;
 b=VJHGV7FGBQDbIGPB2e8gF3Otjn8G860Qdq8Z12RSC7V5WUEtHm08Cx9gWHh+PiUnKUeqNOcUMaxBzq//krVL35pJxn8mpgw/6Srkpm7E1uvutYinJr2VEkGleQqg6dRo0HOfjZ6XoT8A+7kHyGvdaA0fNWfW7hu/3F1PmwcVef8PHkV2AtAp/4C/JOoC89LoEhMsJ+luuwLZdXZc7Sael7FdsrRzYizuUy92umWj8vqsb0M2m0td02gVlqvbMgRugk7kz6iXbpT6Wcae2WzEBciJPtCDM2BlQUQXYyIZritcYYPVyz9X1+0QWnaQxFqLf3zGy07VpzCmh2xW98bn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQJPdPvhN098zi7dGHXazMoXv8c4J80gFbgCTSny83w=;
 b=M+TtmClJTvj+uPRnbQx+TCD3sVYqRJefZ/5j45hqma8th774SBK+n5WZnMtS/rrhdKwFvCmBgnERrF9DnqviIJWSpGy6WA9lvrybcY0lTZsQgWFgeVd4+e7Z4YHm+UVLUDxoXUm62NHGK1woNoKSigM0jusz+3tp0fK824UgXvQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:15:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:15:18 +0000
Message-ID: <d6df3aea-72d5-ef16-1657-2d1e39f62531@oracle.com>
Date:   Fri, 3 Mar 2023 17:15:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/10] btrfs: move zero filling of compressed read bios
 into common code
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-4-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dc63a4-35f4-419d-48fb-08db1bc7ce8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uokgZTQ6O6HbYW84FK7eMAbOETE3IRqwbPFSyVcuQpnoBGoj20tNq4rtYHcxUBXpxijba3BidTDZk3hAesksidDkbwWvN68EfCM0Qq3peEo3uA2HBO6fuqUTRQRlr/1qI24ByZG445k75iHMD2SwUTwKelv8ZT9/2J3rYSPhjR9xyLX+yX0n2hFC+A9Rv4gMhxb5eVsQ+ycD0rtwZWj1FwBUvu66svbxv8Ht7xIOcWaGKRn9kaVjkg9+pTqXxjEZVUlp31w8oDg3xfXLP8lWlziH1tkyF7zpDF2GxvE26ut3xuYpjount8yczbXszF5bAkOfqv2Zatv8a5nkQ1PwR3dSK21CCwLWpanc3wbS+2EiSiZzFw9ZR6Ow78zWgYt06klziwo7XLmpRrvj/2g4HCJ5WYgS4P3CG4pSi3OKUpawF8GgS44kY7u5PKpPhksG4wLM8k//ia7n7VAlZ26hx5gaeWpX74kVZKfHVNr65RMyJPJK/B5hUSEh+vEUoPyMu/v6gRVljovZsKkBPfaAzTD+TAYdvlYa7GvQOmJqVpihk1pmKQnuq9Qp16MxGNlXVs3p7BzSAXdcqhb1VwbzpzLXoIHZlF06wF2bRul6KJV7rEJP5fyaLYHDd0TFOJZ6Vcx7Wk3B4Nm0oOoAuwSUjkV9jGgOOmwXfCH9DxT9htzLcFLmmQ1MMoEG1EbRMHBJWnFomLmmNCDQNrDr2GaPzj7i17+Tj8wkLX7uj+/weEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(558084003)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVueEJKQ3h4cVYxd241TElZUEo5eUgwZGlTNGtMdnZLTjR2RC9wTncrV2Rt?=
 =?utf-8?B?NGhyVi9UQmVydXA0L1pOb3JEbm5WT295WityR0VQWFJXRUswb3Z6UHFHcU9t?=
 =?utf-8?B?b2VTcnlZcmhxOW9YOG05S01VQStGWHRybGxGcUkrdzBidktRMXVGdHZzKzY0?=
 =?utf-8?B?TkpXZHZjNVhac01Yby9paTBabDkrTE5HRmttNk5sRlE5NW9NdHAyK3Y0OXY1?=
 =?utf-8?B?NE9BTjRIZ0crMi9DT1JCNEl6cnhaUmZVVmJaRVdNNUttVjk3em5WUkpBcXlG?=
 =?utf-8?B?dU95cjVBK29OOHcwNXNzZHlNSTBTSFNmUUs0bnlSUmh0b1NQMkw3dWcvWFQx?=
 =?utf-8?B?WHNlQXR6ZWtXNC9rbFJFMklURmVDWHczcU9oZ3ZVOTdnRWFrcHBPdWIvRHE2?=
 =?utf-8?B?dEE2cnBpSTVKVzNRY3FYdGxVWUJyUGJjNmx5MFRrdytQeU8rSnU2VEkzVnNU?=
 =?utf-8?B?aVdCMlZtb0JoR0dGTXNUdEtIRXJKaTQ4Y3Jhd1FaMWlteGdEKzl4ZjJTajhl?=
 =?utf-8?B?R21pSEo4ZUE5L3pMdjVYS0FXNEtDNTdWVFpUN0FhN09TOTZqYU0zSHhnc1Zq?=
 =?utf-8?B?TnUrbE9oYTRtV25JT1FaK3hpaFJtUUZFSGtqMWlYOVZwaUo1MnYvOHozcXBU?=
 =?utf-8?B?UHl6QWtDaGhnRTVoamI1QlVzVmhSQkUxUUNVTzYvcU1rUFlYRzIzRUdEUkJH?=
 =?utf-8?B?citQaFVtVzhXRjVSRWdTVEFON3lkL1FnK2dTNmVDNGV6SkE4MjlkWmNNUm11?=
 =?utf-8?B?bjQ2RUJpNVZGT1M1ZWJYYnAxUnZIeTViNmRPRmRHK1NUNVI4OWc4dEtjU1py?=
 =?utf-8?B?NmdMTWdTNWNSUmVUcjI4K3J0WnJwZWtuT2Y4T2xEWittMHd1NG1TTXhvVGJo?=
 =?utf-8?B?b0x4TDhjYlQ0dnhIZS9IL2dKVjdtcGxZbjdWY3pMM280WjB4dWVhL3RiK2gw?=
 =?utf-8?B?NGlWSlh5VnJCS1JqS2c0QnNsVkdBYyttV2ZmS3dBUmFkR0REUWVsTlNjd01R?=
 =?utf-8?B?VEJNWEFWMUloN1JEU1dpZ2FMYThxLzR6UU40anVOVHFMV0I2bHlrMmdFNVNj?=
 =?utf-8?B?SmR4b2xUYklFaEFPVUkxdngyWk1NS3U5SDJpVnFzcDRCcTJKQUN3aVJEWlpj?=
 =?utf-8?B?eHBRV3ZVWVZMYkNNSk5rNEFKclRqR2NRTklCNGZJMndqdUVTeG40QWljU1Bw?=
 =?utf-8?B?N3hCMDBrelYrdVBwYytMQS8raTBlY1JzVDF1TGttNWtpUGQwL2M5MHZUQ0xC?=
 =?utf-8?B?VjRhSitTYXFETG5KOFFWeHZvempMZnhPY3VvemtMMDRIbFpTbXkyTm9XdG83?=
 =?utf-8?B?UExOK0dVV1RFMGIvd2s0MnQ4MzIxc2VBc0dHelNTMFNDYTVvTERGVHlvcEkz?=
 =?utf-8?B?aExhYUEzamFYeU5GQUhDRVRCbFllYzM0bHlLTWRDMnRHcTJOakhCOWM2Ym9D?=
 =?utf-8?B?YlFqQjk5b01zMVNTc0YvUjJjV1NCbUNSc0ZsNnpWSmpicDA3WUFXQU9BNFp5?=
 =?utf-8?B?cDk1clluZWoxQkFveVVrMXdlV0U5cTdndk5OanE2RkR6Q3lKZGRlT1hBQU41?=
 =?utf-8?B?d05WVFp2U1REMENkd0pPWTJWbEF4dUhra3ZZQmsyQWV6UjBGWkFNTlJia3k0?=
 =?utf-8?B?K0NmcXNSVG50V1lvdXk3cDg1cjVKOWJ5L0IvakF4cE1ycTl3Vlo2TDA0NGpU?=
 =?utf-8?B?bndyTjNIU3g5aDlKNVVUeHd5WWduV2M3bzMxRkkrUC9wYlZyUlM3aGdDMkZL?=
 =?utf-8?B?dERlU0ZqNTZZa0dTaFp5WHdiNDhHR3ROdmtTK1hHTXJXRm4wd3VSNnpONkJp?=
 =?utf-8?B?UFNZa1lzSW4wMFpGRkt0RlBxRFBYNHRvUWxlTlNUZmdEVTBTQ015K3QxM25m?=
 =?utf-8?B?cFhvZ2RwQ3FTQVQ1Y2wwMlRQc01QSkFodTMrdzEzcUJUblQzWHdQLzdnM1dm?=
 =?utf-8?B?Q2Rkb3lWWHVSbG04SzVDTTRhS2UxWmJJUDNhNGNMRnFqbEdVTUN5RHdnd0dL?=
 =?utf-8?B?ZXBrKzJTMUY0TEN5dlh5dUM5SUtKaUFiYyttK0FCbGxDcFk1bDRibjQ4VERm?=
 =?utf-8?B?MUN5c0hHeEQrS3hqR2xhWnBJakY3NDRUbXRWSjhycGI4Ri9zM3QwYTFlZTRp?=
 =?utf-8?Q?g6M2C0pMuC/IHwvdDGwTKE852?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1CCoh9WQPA1FFesKcSOLeeP0GRl1+8yvHrXhtKf8aeSkEAP53a8CK5G4wKoB15U5Qaw8XpN6QtpygEXo408nGVdNOuOPNAeIBCfG8T2Exe7+dOAhCbDS7EL6pAzPHD3/QdQJvJP3kBG0lbhOOO/4GNqgmb9TaXxUmpGymJ67tTP0uEknqI8dKMIJRPwYRaa02aRpA1y60WmHsAGPGjDgNU+cfO0gid3kE6FrS4B3KOd35LKgrSwMw2gdoPuvT74eW0Jj9UUUxomNIzsLWpr+/h7SSf8Caz/5tEDZSstXQqREnZ4fXWGWl2LDpcK50Nkdwop52RK2SfN5nmAvVAfqpq1Yk0wPPizCMa7clV6eqK/zquSQ0bzqh74p4Br1TF5VpG3pa8tUa5azEK0+Hxz4IBJO+m4hGW3CUjBTVTZCCSY2JWOQ0d73JndOvgaxMjY/bRORHkU9ueCtIwffBC5S6sCkdD3Ot9u5qUiLrjbLI1uW3YvuE4IF1kBCOB32g3JId8pyfmlIHihGEUC47NHwyqWrOGI5hjW7ShkrKdIAJsKewmWcsOx900CIeHsWTA05qoMNZqCv0/63jdRaKcjB43uSCQA1mYOy/WZ6yCWjduVoAS9e2gpmoddRTfzvGeLuQiNFKxUjAtWneL77xBAMEInTanMAKROnFECSfDcpI165eccOgOPHKsZ1YjWoZgbZ5s9XA3/jQH+b9v4zu9gkNt4z+R5xGjxrdo2w3HagmmVpCd617W2lK2USvjT35Iir10YywzFIs872zi42sr/IlCRuXC47HkNB0cSDQNFSqeNotDW8RQuUBJgBwMiwWSyy6Mz3Nyy9/B3BR5pF5MUbjAEqoPVsRd/hLW7JD0x1yVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dc63a4-35f4-419d-48fb-08db1bc7ce8d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:15:18.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fk3KpWfQoEqbMNvzsdKdYFgrSQNnMPm1a2YJXv0k/Mtfs3m1PgNFfBlIA36JP3rGEshA7GZDEiJqEluaIbr2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030082
X-Proofpoint-ORIG-GUID: 2wuKZXrER2LQs62mXc-8ZOTjMIyrUHUk
X-Proofpoint-GUID: 2wuKZXrER2LQs62mXc-8ZOTjMIyrUHUk
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> All algorithms have to fill the remainder of the orig_bio with zeroes,
> so do it in common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

