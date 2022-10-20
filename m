Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905976058B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 09:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJTHeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 03:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJTHdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 03:33:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431F16D542
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 00:33:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5oYOH007657;
        Thu, 20 Oct 2022 07:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QsdQC7AXz0Be3rPRcksSreX4mEDGyaJsKmKAuMMxef4=;
 b=LpTsNGbR/No6NV/hsuKGD/4vQ2r1VNMq/YkQFLv/Gx2R0lyU3/e/+dmJ/s/kACJqgBUN
 IgcUhpum0XnEgZ1tRdqYvfZYdeN4rBd2yvDGO2+KoIykEY6F+ffC309zzKtmeCzIhsNg
 78CCWHDZF8vjK7hsIhEE310+1qIXluC0bG+TykxyZVRpWHXS4TM0b8tl+fIk/YaV/DRP
 axtTjCS3KtT+uHFhoX7y6Yo8o+8G7hc68foWGdlZjTc4pyRt4P1lGBGySft4rsWAWn0l
 QGAJaluvY5QFFKjmGV9RdYDVrcGoe+uOiu8cJD+fvYsGyi+efcqAyNUH0m5ReGv5Gk8n KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu04e5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:33:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K4pSqG002725;
        Thu, 20 Oct 2022 07:33:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjaf1m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDYjkP4Z623ER1wlJYpWxrc2Xajh2LcQy1/JkkTMIau8nc0Qh6+TbH6fPb/hAJ71cno+0AWhqVWw7L4zc3FiSsjvBtw6iU+60KzyS/SDttjwY7c+m2xzVSa+a7Xuoe5Al+3cDpfg1qnVnQrhSkD62/YxgdKGSPINzHxpcMznNP2se3/Q2Q162xC/vmES/XXx3/QzPIj86i1Irn7ymzV5G5hswKCD0yzRXbt215BYjZsHPVSF+pA/8jmlet/bxZBJlBF0YrVBzVhqDBJizVm2UF7/s1p5dVVZMg6WuHWX+fL1cWWggYhmpMrf2MKWzPoyOBV8IZGf36SVDWdCThG8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsdQC7AXz0Be3rPRcksSreX4mEDGyaJsKmKAuMMxef4=;
 b=bH3UMiazk2ORNeufGhN4/lWNACAXvpFXy4sR5l36BmxPboJVusYWk8A+mXvZ9xKrJFQwT2QAny5uoQwihkeDMGYBUSfvu36g2n8KX7aQemBNRSp4Nj00dCTfk3GlWmHOg33dobMkzYmZ6V7ivWn0hX9Vygd/p6uTyD0yj+O6Y/nUDIid9PhDgj9n2CY/zUe9a2Z3ucd3DQVBg+CtvOUaNiW+hLC3vIpWa6exrOJ6S+p3+h5AIe8aafGQcOdLFoQ3r0AqT1RfZj7rLtjlfqQTxtU+CLlTQI8Yb40NFEWUERciCiv6ZnrpPdQYterT87GvKTmmd+qmi7G/Rsioq6zWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsdQC7AXz0Be3rPRcksSreX4mEDGyaJsKmKAuMMxef4=;
 b=NJi2A6QfFjMrXni6mt6/wqgaY2HBe3G/0Lp+nJnJrDAAuMsdh3u5rZXjxJiyMgjRT1Aqx0KjCVEVmxL9aRXPFjsEF4/YC4ue2oNMVZb0NsqdRngi4YkRLyj+MLYoL0hFHe3jZ+/uHqvVIoe8gyioAcaW5cRBvtBkksidqUHu8QM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 07:33:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 07:33:31 +0000
Message-ID: <4cc7886a-5c15-e37d-8255-5e48ec95e7d7@oracle.com>
Date:   Thu, 20 Oct 2022 15:30:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 4/4] btrfs: sink gfp_t parameter to alloc_scrub_sector
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1666103172.git.dsterba@suse.com>
 <a33272553ef02334c55eb6fea1c286bef8c7c871.1666103172.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a33272553ef02334c55eb6fea1c286bef8c7c871.1666103172.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 378c15e0-e3f2-4981-5ded-08dab26d62e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DJRqytggPpfFsRpkOpoSWbAQ1eKHoFGO535AZG64C1xKKYwvY7UoPFUx//U4GPj475RGhecICMWgrhTwVCCCpOIq439Ugr3fHl/+/+isju7D4Xux84/yoZYUa8T79ovR/3pyEYxwM5KgXrmMFueKMDjDg7k5ApVHReZuX99gZACA5896WzuJqVzZyVIGd6HUXYkpranYZcChyDCOQ72CaQSNdEl91WOuaLlD5pNWN0s3Uzxd1HMd2dtd8GuClYkG9J7KbIDHd+ae3T6auZeqAATJ1giLN7APsL6gEIwWMmLuTK/3oz4bC776kGIG72zTd3P3IaEUonPnIA98Q9Glc1VkYCA4sq4eBvCEoWzvjaEF4GjMd+bdyagdmir8oU1+lr422eJqJy96QlHeSHPEIIlh084RcKs5RAbCuqLNR0bTF+SZYO5od+uNScsjfsCCEr0CCtVTB7tlD5fIM8u+1jYTXAyV9WCNnnnVF1htz32Tjw1wEkIKqaN9xR2wo/8QJtNpbYsT2NQvGI2UdQPDuGjnb3UvKVG2YfTa2vLQiaacddJWa0yXEBGmzQtFuTkoBa3re01TRgBHqppQQTl1e4JYv4U59yAV6uAq4MJ7JTY4xZKOcx2DYt91VlZEAdzaf1DGHx5+fLqHaJtJvyJAShXF3mdrTgw8RuJ96RAa/dJYTbgGFLN0nSePlmsa+m3wIP1U/RZZu7GVVt8yWq9/3WcEQ5k+hO3uwEqLqs4jtVf7nwWLgEGhG2PHVGncQ5Vxi5C2/l1EVjuT3xN8Ec0R0Y71ri2w/54s0PW4AkuW8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(38100700002)(6666004)(86362001)(66476007)(6512007)(31696002)(5660300002)(6506007)(8676002)(8936002)(41300700001)(26005)(66946007)(53546011)(558084003)(66556008)(2906002)(186003)(316002)(44832011)(2616005)(36756003)(31686004)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnQ2SmZFTlZkSkoxdlo4dmdEYStKS0NuRW1FWkJFY2N2ZHVVTnQwMFRQMWpk?=
 =?utf-8?B?Y3A5Q2F4dEI2c0VhWVdnQVFkcHVJRFBBWCsvSW50RndRNTV4YlBZYlFYN1Rn?=
 =?utf-8?B?MzFCZWdaYzNJZ2tNczRLWmIrUHYyLzRkNDBBbEhBdG5YaURJcEg5ZWszYTVJ?=
 =?utf-8?B?bGZPWTZEcFZjTlFBU2JNMklqRHh2bkdaMGsrSlF2Y3UrMFl2cVBuUThGTjVv?=
 =?utf-8?B?M00xRVVlZGM3cU50SmJWQTFZWTMxM0xubktJeVhKMVNiYlg4bHFZZm5vRVQr?=
 =?utf-8?B?eVZja2lTQkVrYUlFVmdQMW5semZWWSt6NFYwQWEycWhIR1VUUnAybTg3djNN?=
 =?utf-8?B?NWp5bTMzSDlwMWtDaFZXT3h5VERWazJMZE9rR1ExbzhmWkJvSlRSSjllMkRq?=
 =?utf-8?B?TnpOQTByS2lvV0hjNVR5MFJMV2JORjViK0xyYWVIVjNGcG90a2NlQ21YdlNt?=
 =?utf-8?B?WUlacFhFdENvRytvclJMcjNUUkRGcHJ3elFjVEE4THpVSllHU1lNRUt0OWIz?=
 =?utf-8?B?cnZVSUpwcDdrb0RNTFRlenpWQVVXNm5qN3g3TVljNXcvbGFJbTY4ZkN1dGVq?=
 =?utf-8?B?NlRHd3RkZUkyQW4vclVTQnpYZHYzSXJlWEF0MW9GajRhejIvck9ERXBCaDlC?=
 =?utf-8?B?MllRbFpsQks4MnR4ZHhiWmRtcW9lUFRsdmhhTEVrd1hOamYrMzB6a0Zza00r?=
 =?utf-8?B?OTRxSFB2MnNIVnBnYTJmbS85cHB0Tm5Cbkt3cnZjVEx2Q1dhYkFtbWRiYjlS?=
 =?utf-8?B?cFFzaEdOVkEremRNVWlKWjl1NjF1anJENGVxYy81TWNhcWY0Sk54YmZwcGZX?=
 =?utf-8?B?bldXMG1YaWo0S0R3eitoRlV3SE50UVZreEIxbTBaYWsrdFR6RUIwTk5GK1c4?=
 =?utf-8?B?RmFyZ2VKWk9DcnVqcTJ6a2VJUTZpcEo5dS85OTV1WVhOK0s3YXo5RDhiSmow?=
 =?utf-8?B?bkR2ZlcweFg5SkxxWndweFZ3aW1NQVRxM0ZwWEZKTUVzaDM4T01nN282amZl?=
 =?utf-8?B?bGI0Tk1xQXUwMk1UN3VKaFRGR0ZndnJ0Rk43bFVoZ3hQZVhMTzBRQzFLUDY3?=
 =?utf-8?B?bUd4WUpramRHLzlya3ZwNTRydGR5TkRNL21seVU0alQ3WGNWelY2SjRsbkdR?=
 =?utf-8?B?aWswZ0NsclJmSmphRUg2aysyWGNvUCtXVUVSMlNaQ3YwZ3ROZXd5alhHZWM5?=
 =?utf-8?B?dWc1dE5qUHZOemx5Z05Vb3RrazhhL0l6T0sxQlNoVlg4TTRwS2MvL3diRUlv?=
 =?utf-8?B?K1owRmxCZndZbWRPdTFFM3VOMWRzclVUbUdETzRYYzNvNHBCc0lURUE1RWFU?=
 =?utf-8?B?aUFac284Z3h0bmtYT1Z6V1M3TEh1RFZQQlRpcS9XRTkrc2VSeHh4U3lKbzMw?=
 =?utf-8?B?MkFSMVVsN3ZmVjNQdllSYlJ5cUw5ZWlvY1BsZlVzSEd0Qi8zTHpGZ1RsT1g1?=
 =?utf-8?B?THhPeHhCaDZ1bDdYZFBHRnNVOVFGYWdoME45TFVLdmh4bGp6U21meXU3UVpz?=
 =?utf-8?B?MlJsbmlMc1I4d3dTQnpQMFhJaytpYy9TRVhkV2pmd21jL3NMV25DeW9KZEk1?=
 =?utf-8?B?NCtsS2UraVRBSDA2YjY5dTMwUlhkMEVjNFNudE5ySCtWMXZVSW43dUZVV1lE?=
 =?utf-8?B?QUVuTjdBdjF4d2lMdkpMd2Y1NFpMd25zMWEyS3RRb1VVTmwreXV6b0tLbE9z?=
 =?utf-8?B?ZUdlYTJPbWNyVG1jVU81ZVZOZ055TXlUck1mTWR0WHA3dEU1Snk5cHlpZU9t?=
 =?utf-8?B?aUpybW1kbzhvdnd0SXpmUUhKTkt6U3pidzBKNlJ1U2dENUpLSHJYaXJDTjlT?=
 =?utf-8?B?QW9scFM1Y3BsYWtTdXhUV29mb05waE9DcVpBR0ZqQnpoTkYvZ1BxZXRJYk9T?=
 =?utf-8?B?NXBNYjNENUNYWjJ6NDQ4WC9oWU51d2I0VjB3SVBqWkFFaGFkcGRFdUFBVkJJ?=
 =?utf-8?B?WmFDSk5EbzkySnpsZ0ZKYlU5bGFHTjVUdFUxWVNidzhPRXl3MHMrdXZjOTZj?=
 =?utf-8?B?OFhqOUswcEhqVkZQdFlkY1U0Ly9UQ3Y4RC9pZE9qVWZETGovb3lscGtENGNP?=
 =?utf-8?B?czJWWG1qTTBOSzhGYWE3bW14TDNGU1U0ZE9vbGV0OStCS05hb0plM3NQUFFW?=
 =?utf-8?Q?Tvb/uoKuzL3JYbSM3Q44YlUhf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378c15e0-e3f2-4981-5ded-08dab26d62e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 07:33:31.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: affHTtBEYT2VppQfhf0I/INooHVMazR2Wq1/BevEwP4NPDDlrJPkOzC5x3lMzC2f0x7fmdhbvpmxfcq6fyUQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200044
X-Proofpoint-ORIG-GUID: oOwYrj1ZsGKAkn8UKpBR_Ay1BRQhrQgY
X-Proofpoint-GUID: oOwYrj1ZsGKAkn8UKpBR_Ay1BRQhrQgY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/10/2022 22:27, David Sterba wrote:
> All callers pas GFP_KERNEL as parameter so we can use it directly in
> alloc_scrub_sector.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

