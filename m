Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9375EA11
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGXD1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jul 2023 23:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXD1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jul 2023 23:27:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95BD1AA
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 20:27:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NLUgqn004239;
        Mon, 24 Jul 2023 03:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pwn2thEipetFRTcjqt9tsJmH/1gI9w7MYb9jDiu9+w0=;
 b=OG6O3ZdTRZ8b58WjTkuKjbFfitYl4ZPVS8Mo2IKvBPiSMgPJUUfIwgl6dZ53c9B/G1SF
 Mukzezhp8yKoh9hi+FMS7nWQFfJvXFLGbJSsxDFHucJqhwalIsz967u2EvPv+gVTNqB2
 BHCfmI20VDnaUvV80JTVs/6ezgW9wDo2URSUmF0e/IHD9AtItu95nNWKXbkjaU7qFZsV
 SLdLODDRwGtxZAlRE6z/tKyjQuOCkJSPb4MLm3/3qNe8zvrvU+p8+pPke/RyWHr57VBS
 uNhfciXbyCqo9XByU6iOoJBg47tg+GOWgDTMRh39rJYnaZtcEJT9SNjuD74CpQhV/1Bg JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070asr6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 03:27:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36O1kBY4027516;
        Mon, 24 Jul 2023 03:27:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j94yq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 03:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsG++27mQH7ug6FlqwJnsxyIu/D+x3frAG+YC+GsE6K+2pkt+sDG026XGfB1/tn9r3VqXchkLIoJgibPnUMx2GRn/b4GomoNAS/FEDFHe8TzGTDfa4M+PIYVcQ50m9Xig6fqPPV6OuGOaZwZFYKuwfNu1wMQ+lXUdIZ/jozt59wSwi+1mr1RmDhEMw48RbVLSWW9Xtt/ZRqq9fB4OBGjVJsadv0U+FWZPUToetJGRvJpDLcniqpfChPGjPmPAOudaFarl3JbK7Y64WoKm1tOkRYonibMaxQ3JUAJjA+CTZlEUar7JHUo1iFvdgeUhyrxHXlPwm0vWxircYib4b/uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwn2thEipetFRTcjqt9tsJmH/1gI9w7MYb9jDiu9+w0=;
 b=hN+dtoKLTHXlMRrsE946ZZnnj1om4sEIpljA7KjI7tiSqMOXUhknw+SCdvMGFH5GM5w4LJJpfRlPfAFAwAaAs9LFmqgRkfvoWdGGjsG50lWTgzR/5XliFHxR5/SXJspsAE1muqFF2wc5RM/fYzBIys89FM4xrOGOuQ9iFIIJkBs6ygx6DfpmL0DHF87TigPhwtNJfCKa0L2Tpi9rgcAHx1RrXPVzyfmkg6oazLJ0k9LpqjHX/8baA4T62usFqaO84/3oz7hRqccvyJkuGQChxUvVOHCa7nm6la27GXX/HCwmMPRDXVLIWYBglkybA1c20F7naarp0PYButXbY8qCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwn2thEipetFRTcjqt9tsJmH/1gI9w7MYb9jDiu9+w0=;
 b=OqThFtnxtrQZgrLxZazypU0bJV/7LEjcf/oe12BSjnmQbPIGc4YY58cev7ApqUP//v0hnU3NJZRg5klfcObXrixW1ONukM4r7t+rsRpJjP2lfGt/CpF/rG59KGRox2ExNKsNyER0OuhxPx7ZMWWexGvFLMIDzaAq9CIcKCX2XUI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 03:27:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 03:27:41 +0000
Message-ID: <303f4dab-1143-0ef8-444c-ba57e13b209e@oracle.com>
Date:   Mon, 24 Jul 2023 11:27:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
 <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
 <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
 <86568e50-7dac-2c1f-c678-4b63ffa5b1e0@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <86568e50-7dac-2c1f-c678-4b63ffa5b1e0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0383.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f12777b-08ed-4ec6-afed-08db8bf5efb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K25zXyKJDVjX+h9WgEBSRz16JRJjZrSWjB0EiqJS6DUT76DF6SLbTx651y5DNQJNuBvhW1kotLd6Z1gb8I9ex9RgrjF0tOtfRUMPeDWrLvqt2vA7IUktkKMlIVo+mO+3wfFfqYAqLuSwOfIRYVHwMZqVEp8IJBtTNYQup5yjj+tIBwQeTEeKqRqGI0kkC2nkwn27DpXjhYECGIM0YytvyowdB/Gu/Yk8qaZgmnJYeoHd3hrmGtz4OvvZ+Jbi4xXkZwQMF3U6+1ULVfZy6TkQBpn4NZEgfGazkX7yQ55OM0IWJoWM6ehtXEgl2+04NqPyiq6rSZZ1hlTCLR1rAII0hXyvB3E1oawJG617ZW+Ki8a3qNws66VKBrr4UaOEJtdghgbNkrSioqgCxcA+9ky89dAtIELZpurE2ZFV9oXgZYMUGacNjzRUJC6kt7jSJ6c4tk6TDBweXLdhmsR7B5IyPg52vEqap4JpO+HYJGjCcjk1O6ocI4yUEHxzDxEOTWZQxt5KB7YlpjmynoYRXE66dIVxlNw0XooqPSaQerK9V1ZE5Q8YZHH/PoPaa7tqbSmS0WjZ6hnXy7BoD6CkE3GbSJFm2xOX4TBi+froIaSxVzwwyhy4J1hiryr1Lc5Nmkk8NEAeWFBHEE5mjS+p1xBjjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6512007)(6486002)(6666004)(478600001)(110136005)(186003)(53546011)(2616005)(6506007)(26005)(2906002)(4744005)(44832011)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(8676002)(8936002)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHV3THlPUXkzdzlaOG5nTHpQUW13Ym1tSXBsTVhIV2JzM0RGRTBYRm5Ec0o5?=
 =?utf-8?B?MEN3RlMrKzhXWGZoeUo0cVNWejNCODlSZThPQWNZdlRnOVowK2hTUTRkUzZB?=
 =?utf-8?B?d2xldkg1d0xZNVRMVVVqd2o0U25HRkdQemVkdXp2UStGRG9tN0pYT1ZwVEN4?=
 =?utf-8?B?Ryt1bTlJdlRUdXBnZlBsdXhkM0ZrV3d3ZUtvT0ZiMzdHdWhPdGViaUV4YjJv?=
 =?utf-8?B?WEQrU2xBMHEveVpjOTNHSUNXdHNaREIzMzkyQmNxdFkwb2ErVU0wSG5tL0ww?=
 =?utf-8?B?TFlaSVJubnM2U2Zvd3cvWGk1dVIwTGdJV1BKVUEzSUhmYnF3RG9WaVFXbUM2?=
 =?utf-8?B?Wm5TdVdCSmpvcnJ3bmp3ZTFSSEhKMjBEclRsVWVyR1FxNEhueXVmUnpMQlVo?=
 =?utf-8?B?WnNhSEIwMHFiSWVxNTRhN01KcktFR1k2MnA2WnU3SWNYQ0VJMEpUMWhVSDRm?=
 =?utf-8?B?TFU3RVpWT0FBTHRSYlgyMjZVL2IvQy84MkFwTnBDaTk4WFB3Y0YrNm9mZkt4?=
 =?utf-8?B?Z2JzK0FtMGZYWjEySkM5QUVobEFxemdzRzB2SElSdVFsTjd4N0VqODFEOTlX?=
 =?utf-8?B?UFVGL252dGJ5c2ZiZGJ2TWlPdzBuQ2s2bTFxM3NGV2dZV2w4SWQ2NjZrdm8w?=
 =?utf-8?B?MDdBL2RQcEx5Y281cWE4QjgxS0Zhd1NVUDBSSGZqbHg1ay8yVExtQkpPVWY1?=
 =?utf-8?B?T21FSEZVQ2wyT1BkYjhnV1dwWk1WWjQwTnpZM3dYTGhwMDFpWFd3SExyRXhZ?=
 =?utf-8?B?eHB6eW5IZjNkcGM2TXowOCtGc3NsTjFOd1dmRkM5RDlTbDZEUGhERDdVdTla?=
 =?utf-8?B?RWhDZFk5N0lHL0pFQ2h4ZnhTWFpoY1l1TGVhbHYycFBiSGhqNDJIeFhza0xB?=
 =?utf-8?B?a1c1dnJSSWttc0tnaithZzc5V1NBMmxLbjExVUJPcmc5YTZhbEJwSnVSbC9x?=
 =?utf-8?B?SS9Ndm15YU0xY0xTUTdpdU5XZ0RjUkNZVUxzZjRjaUZCZ2NwR2lRdUdTd3l1?=
 =?utf-8?B?Q0pIcTYzMGVqY0xRejY3b3g4YityYm1CYStsbkZySGlmL0NSSzlFY1RRUklN?=
 =?utf-8?B?YjE5VWw2R28wTTl2cXBxWlJwcHZpQ0Q2U09IcEh3MFJHSVYxdmsrYzVpenJ5?=
 =?utf-8?B?aG1nblFuRVMzLzRHQTE1VnV0YnV5UXpqUHk4b3lSeDhDaW85Sm1KdVBTaGlL?=
 =?utf-8?B?S1BvSk9OQXFDZlprWmpLOEwrNjdyVVRNaTdxNEpXUmNNaGROSXhrdFUvSjlw?=
 =?utf-8?B?RWI0ZS8zUkd2YThhQzRBMHJMUFFlbCtFNmdRc1VoLzNGNEdrY0htbTJDSmlB?=
 =?utf-8?B?RlhKNDI1OFYvUGNuSWYyajdFRWJ0MmNReDNobmt5S1JvSndFNGt3NzVScUpa?=
 =?utf-8?B?dk1HaDdWNlZjOGJRNWRFR2tZZElNZTV0c1gxTmR1dWV4amJDbjR0OHZ4K1F6?=
 =?utf-8?B?SXVmc251S0p5SjNSa2ZmTktZZXRHOXNxWWRrVVoybis0N3l1aWRQVFpqZDFD?=
 =?utf-8?B?SnE2b0Z5YzNrUlRJL3JGVnQrbGVXeHBvSVdPdy93NHhMcjlSejEveUtJVTVu?=
 =?utf-8?B?TU9NendJRitBZ0k2czA1WEFocm9NUjFWTzA3NHFSVFpvNVE2aVlYWVlOczNl?=
 =?utf-8?B?MlhwcUIyQXN4TXFmT3d0M29pT0hvOXA2TWtYaWlSL09BbTl3OUlzNm85bkd1?=
 =?utf-8?B?bUU1a2lNbTR5T09FWkZjM0tlU1JJaEpZdHBMM1RpbENxSUx0aGswQzA5R0ZY?=
 =?utf-8?B?cCtoSk11UHpUaUo5eXJKK0c2YjJZMkZzSklYQ3MyUmgvYU1sSU1kem5xaU9W?=
 =?utf-8?B?SWpDeFpudXl2SUd3NGl1U3dnQTY3V1o2SmgzekVmdnNWWU5zWDdnTGY3cEo3?=
 =?utf-8?B?WWE4VTlNOURHand4c055d3BET3h4ellMUGJ4VER5Y0RnUmFkZE9JVGYzRjhO?=
 =?utf-8?B?OU54cWZUSFJVaHBsaVVnRmpFZEZxa0tGb0N1clRYTjd6RzZPL2ZPdHdFVDZN?=
 =?utf-8?B?QkVjRkpWK1ZibWhkcS9UUzM0bUJ2b2ZCQlJWSks2Y2Q2Q1RwSU5rZDkyMVNn?=
 =?utf-8?B?NUtLNmF0Mkc3Y2FsN3I1U2R4VTZEVDNwemRNcmhXeGQ0Nm5CRXBWZjZ3RGRW?=
 =?utf-8?Q?QncimZiKjS6e9t6HeA2xkWCdV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dEzS+5yHW1rXP2p8Cyaezlfmn30aE9yJZRYR6Xu479uJugaYPJuO2Vffu4F9vhpkOEVZBt2jCSMjVIb88XD/KOMifUgBBASUkssqi0zDLMuAvGncO+7wcU8CczPTVcdEZwxN1OiE9HomUJ62c7RZnKMybjIvoIlGae0xCOGmtVWObE03sCJDEsgane9z9z9NM1/x5rI5Qekd0OyMxar4pk67/eF/raI8NTY9W0kJ1RGdrnrKwBbLNJPR6vTAhUHU3rwcQ6jYyTgyjU//IixdoCpzLFChBQH2DdF9/zdvc5vq7mlnP4Agu/yzdoNRvWLc6HusLLPWmiyPk6jIxJ8RnYwYiWgye2YZFaumHr5tv5/mGOhHNjGAmK91QbvXjNHkx4gZsFp1o1QzXAtAmgoZd/zWfte9kdhQfh4tQAXCkMmdceUtUhN9T56puW7vVqzVV6Mizr7CXj9VcKXXC2UYAorbf2B0UBSg93kxZxGF41cRb/4tkLVOHisCmOwVY7wcdfuJC80SeoERAW0iCtVNWrx4b0ku+d2QuLzg2/ymRYZYiK+qDO58puwzPLCXfy01vD/BJqRy9/QZBokimPCMw6goud+0255gmE3V/NxpBKyNQgepaCehqjDneiKA5Mj14uyWDFhrfJ9kgzln5XAvpWRmnhcki+xglrN5iRztox01F+N/h8pfju0PX7A8UcLYLGiETJWP+zXOMIjlwLIFFZGfAAfS+SiZhcFzK3VjcmvWyev/eRpvI1lXN6QWn+n4ITvnwVyF/Sh0K+JuHJvB15gmrXJ24uEpTkwAETp0/CgC3ZxZSV1dICmgaiWSdxgGElURfZ738TWu0WosvE8shw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f12777b-08ed-4ec6-afed-08db8bf5efb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:27:41.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCvbSs22sYNZZjryjxCes1YBVlYrbF1822pdjTn2SvozP6CGVfbzUh+iMnrCttdFZyaffn2lfe74bG8WQQr6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240030
X-Proofpoint-GUID: kGtOnRbRfCCFIvTWSFHJNkYW_gzc9ebq
X-Proofpoint-ORIG-GUID: kGtOnRbRfCCFIvTWSFHJNkYW_gzc9ebq
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/7/23 03:11, Andrei Borzenkov wrote:
> On 22.07.2023 22:07, Eric Levy wrote:
>> Mounting should not be
>> attempted until all devices are attached.
>>
> 
> btrfs does not attempt any mounting on its own. You need to raise this 
> up with whatever software component does it.
> 

Yep, systemd or whatever should call 'btrfs device scan' before 
mounting. According to the logs, it seems that this didn't happen. As 
the device scan occurs later, after the failed mount attempt, manually 
mounting from the terminal is successful.

Furthermore, to understand how it worked before the upgrade, you can 
share with us the boot logs from the older kernel.

Thanks.

