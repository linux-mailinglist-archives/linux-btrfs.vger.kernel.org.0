Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E718078BB1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjH1Wns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 18:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjH1Wnl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 18:43:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7918F
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 15:43:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxBdF005430;
        Mon, 28 Aug 2023 22:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ctiRHYojD/juKomphRcFri9B7SsGGSdnX9W4+7KF4ug=;
 b=jb23qGai2ZP5pfXrFA17f76Ul6UYZFC50dCn18cLf/QAjP8Lz031Njk49vbV9KSD+sU4
 eQFxn1sHr9cBqUmKHk3dX0hLXiOa0sgHA//8XHF9sNhliBz3vK9NlvzvRSG0jW3jH0gz
 FXKkqnaRor2hnEuUCTqDSpyofHYPgV18wFDmA+1MmcpQnUkfZUg/p/61+d/8+05oTSYQ
 67o4OdrTaM63hmgn+vX/smxwJO1jZB/+w41hBIuxKbB8hZZYYbaVdDkcA+e3f3Dsbyd4
 sbzJo0dIJc4xmV5wZcQfps42kZGXTzd1du3ctUznphNxcPtd+CYz9Ap8udfY7wdwN8hN ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4bsmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 22:43:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SMUNKo022985;
        Mon, 28 Aug 2023 22:43:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hmafft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 22:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuaF6sbyg6g7E8/fEtcGapKgrrTNZePvg/TGtY9YiJ76BhVdgpMa5i/n9Mubu8wVfb+egTZv9JJT5z6GCro1DnwD9OPaUnGOHL9j91tF2y/1dcd5LBASM7crE929Fxm9eIgkI9zDQ9HgoggG/+uO7FJzaraTO2cn7S7ehv1ba1fUIMeJHT0wZymZH3lUewhOTu0r8USd+xcJjz5K5D3uR0+A0VpQnUVxyKkvTwmYnUZBWJdOUiBcl3bcReMJasRjpIBkXcATRQvYd/22YZ83Uwgf28XCXxrGuGOAe5pdvlQRaq/mi6rxVA3DOD6ZaXT9zlbiSXgfOH2UorPKp+TIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctiRHYojD/juKomphRcFri9B7SsGGSdnX9W4+7KF4ug=;
 b=eOzLP4GhTzaHuTRPTU2TVFz10d2mycGmIY8yfdoWeNVaVncFnds2mcl2KUk//ygSP3/2opU6289qVh52cOe1uR3n9GkYXS96KCIEFXxcCV2yT5bOCfarf2IKnXxNw/rz8mc3zqL6wH+JMqGgxGBBo5gxjvF3bEWwEh07NQPWH8pVhdU+03eNoyhhZ8Q2ZY5ko2WOuDKdAU1a5CyBfUImbK8sUU2/Y5pnwfjPUqASXLSvzsn5XShPQeDh2W/tXTCUxzhUWg1o4cz0xYKnkiLEE+QVYpZQrVPNhW6WLZo/8Amh8QN8VYlVEMC+rvvhmMWQREtNpQAUxBcKpljD82dvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctiRHYojD/juKomphRcFri9B7SsGGSdnX9W4+7KF4ug=;
 b=U3uhjQPKL6wI/WCIVIQzv5dlV73nt+i0IUGzFLd5NlP/vNzOj+SbFW3i3jBZyzLJK68arwFlZVamVY1T8MedWAjjzqvUKh230pX6Csyib9iasW1IOqqvTEqdSaAm3XeVWiUnlVHCYoAiOL3sCcLS0kMoQm9U2If+hjb1TkQIZGc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4253.namprd10.prod.outlook.com (2603:10b6:208:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 22:43:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 22:43:28 +0000
Message-ID: <4673690d-c5d5-c40a-ada4-d55bc515c3cf@oracle.com>
Date:   Tue, 29 Aug 2023 06:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] btrfs-progs: tune use the latest bdev in fs_devices
 for super_copy
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1692963810.git.anand.jain@oracle.com>
 <c76f142e562f0c337cbd657b07fd9105e5ff34c4.1692963810.git.anand.jain@oracle.com>
 <20230828152729.GB14420@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230828152729.GB14420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 69faeaa0-76d2-4dd8-3060-08dba8183287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9Lw+OkIQyxRbsidYhJZx8RjzMlInoCMBZdWaQ8Z3v0rkLQGiu+KOATMUicJjWhUAfXwzIhin7XthsjROEG7n4A8iW0UF/4SEz1atoxR/EfBWIh0c8N7SXfFSKuSSz1/bgmbjlay+SzHQFA2DYAugjlCb+aJ45wUqGzCfRfbX/FQuFfCF/i0GmrIxfAPhTLgnmKj0i1ltMnvhiUfo1NtahXAFZCj3ZVTIqCcWYCAIGEis97lgpqF4+Q2Wp7dcyYHNCvQVuCJaCmPT31W8QGj4ASHsYvQ2PcuKOmZY3uZZAqoCc68Ki+kE+99S3V4TMPC3hS3JqSRJLEO1f0kcC2RrFAefhj1DQ8RqwHSpWfPs25C9surA9XdDH2CymCWXO3qbWCOiceXqEig1z9wkteH9XVbnBSktaJ0ztqRYf/9s+rfX4zZ/cpNMbwIt4JuvRCPEYD70taGUZvcnAnVQxsPiVvQ4CqXwHFfbj+yBNgQ54zRayx3Nz2RidBanth4xxdv1A+DrHjaiHbxVTz4E4PJPAsevhBhKyZOo7J2C6ldhZEXPtSg8V6g2BfUCgbtTV2fp8wJRaWUnBTFbajoE3pG5X25U6yuPFzOnd4uhiZufEyjIss0vyARIR6UB4WLkBSu9PP81zELUB8sqpTRBmMyvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(6916009)(36756003)(66946007)(66556008)(316002)(66476007)(5660300002)(2906002)(44832011)(31686004)(41300700001)(6486002)(6506007)(26005)(2616005)(6512007)(4744005)(38100700002)(478600001)(83380400001)(86362001)(6666004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxGdDhwbkhSZmdraUs4eG1CT0lNN29mcVhORXJxY01lOGFYV0NWWlpOT2dr?=
 =?utf-8?B?VHEvOFVvV3FHWmx5cWdsN0p0REljQTVISlhZVkoyT3c0UmNnbzBvUjBYNmJQ?=
 =?utf-8?B?WUJoRExITUdORkhJRTFZeEgrQ0QrUktSUVdkWVRwUnB1dWZZclBWK1ZBVFFz?=
 =?utf-8?B?d0MyY3ZKK2dsSG1mU2R2aEdEeTVZVW1DZjRnVlh6RERjNGpVUTFrSk1IdWFT?=
 =?utf-8?B?c2QxUmY0MDNMRzQ5QUUyTEYwa21LZW5ndmJJUXRvL2M1TmgyYjBlUFJkcHk5?=
 =?utf-8?B?c3I1UFRmM2NQTzlOYW5pamtFaDdsZnBpNk9uUVJpcXR0SlJoSWRtNjNvU1NN?=
 =?utf-8?B?c29vY0JDT21qdXB6MHdyaFAyZDhJV25lVGh1ZWhpNDZWWFZIU01UYStsdkpi?=
 =?utf-8?B?cjhBblAxcVhjMEwyRkltWEpLVDRQMDZFV3p5MmM5VkV6Y2xpY1Y4Rm9SQ2xi?=
 =?utf-8?B?cmY5S3ZybUg2ZmFGUTRZYjZ1VUFyVjlPZU9MTFE0U3JLYUJrY28wakVka2tX?=
 =?utf-8?B?TjZJOVBOd2xWenhORGRwaHplK3B4N0ZKb084QzVZVFk1WkFmVXFZa09mYVFV?=
 =?utf-8?B?RDBsMlhtSTBDWGx0Y3ZnWWN3L0YvQWxCaklSdGFrTWdFZCtBTDhyRTdOKzJm?=
 =?utf-8?B?aFUwaHAvdzJlb3pBQzgzZHRWUHFVcnhkV1o0ck5JSEc5cisvdkpOSFlDbVBa?=
 =?utf-8?B?M1l2WlllS0JWT2NjRHpuQUdwTURXWGNpOTRBTk9ObmxUUUptV3FmSmFZT25Q?=
 =?utf-8?B?bGhaTmRWNUdpRmZQN0dCRjRpa3FJMTdRSklxYnAzYm1mVWp5b05MbkpCM3JF?=
 =?utf-8?B?dVB4Mjl0aE9tWTdmMzdCcUZBOGNyc0ptUDBSOEhKUWFuSzE5M3Z3YlFYN3pG?=
 =?utf-8?B?TmN6UDRlWG4wb2pQcURXaURmMHFaUFlXSy9zSjVkVUdTenVhU3paL3hhc2tB?=
 =?utf-8?B?M0tpMnZIRWZqQTAwU2VONHRaYmdxYklTbS9OMitDUUFwN0w5Zy9PSk5sd3R1?=
 =?utf-8?B?RUZvQmtGUXNPVTZpcWd5S0QwODdESnlsUnlGbVpDS3QvQ2FOU0ZIbkVsRngr?=
 =?utf-8?B?bXp6R0tZTVdXVlU1Q0o0UEJKVjRBc2VyYzZPM09GREhRaUtCM2NhcUkxUnZm?=
 =?utf-8?B?ODZXTis5Z3RtWWpZYVY3RGJmNGU2MnpTWFhiaDdmZ291VExVVmVOK0R1VmRp?=
 =?utf-8?B?Z3dvZE9HKzU3N3NKRko4RExhTXNQRXF6UmJNSFUrWjF5aFdMU3o5MlJHcnN1?=
 =?utf-8?B?TlI5UVVZd1FCNGc0VmxOTEpTVXUzNlJsRlZZRUcxcVRqWDlqa21pV1Zsc29l?=
 =?utf-8?B?anM3K2ljV1J5ZVBFSnZPTlpjVmM1dWliNlYvVzNtdU5RaVVuNjdNMEQ5NTdz?=
 =?utf-8?B?L2p0NTdMSUp4d1hCOEd5aU04K0MzUUE5R1M2NFgvS1F2VXpUS2JBRVptUGFm?=
 =?utf-8?B?SlFYWU1iK0hOYlRQMVl4SUFJVHpNWVI3VDFRdXhHT2RTWGw5TEF2Z3JBUVQ2?=
 =?utf-8?B?RGtsVG5UQndvV1dFcXY5K3c2RG01c1hudm14QlJuRFVBWDMvdGtXV0x0N1lL?=
 =?utf-8?B?VXV1WWljNGlLbUJ2RjBxSERZa3RDeC9wNjhaY1BudUhXOWdxZ0dBQkNobjVz?=
 =?utf-8?B?b0U5eGNNbjU4UnlzMFNIVnZScVE5ZmxEbXZTSkpaeFR3TnNhODVONnIrVHBs?=
 =?utf-8?B?VGpPWFlaZ3U1Ti9qMXdKa3pFR21LMTlQcE1nL1kwNUFoaEZVaXhRNGIyZFJi?=
 =?utf-8?B?TXVMQUJwSE9uanBnazFUdHAvYnBmaHlOU1pHQ1hHYzh4bHgyazVTeDBNZVdK?=
 =?utf-8?B?bVhzK3oyRUdJNTcrN0NFZHVSMVhrRjJ0aVlHZ3o3VGpNeVZ1aE5LTUUxQU4x?=
 =?utf-8?B?VWppdTByWlk5MkVUQ3oyVjlCWGZPRkZrTFU2MW5rcmZFMktuczI1U2k0UjJr?=
 =?utf-8?B?K2FoVnVaaGFLeTZYcnd2NnVmc1NwUER4ems0S0FncHg1MUlOTkR5TVlKQzUz?=
 =?utf-8?B?bktFeHFSN2l2Ri9aMms4dFZQY0ZKVytyd3gwQkZUTEw3emlsVzBiNGExMW1X?=
 =?utf-8?B?L1kxZjVWM1k4ZHRpVnlVNnZzVWppby9MbGR2bi9hQ3NpcHVQZUZPUzZIWmtw?=
 =?utf-8?Q?Ec8XUQMo8OcjZWolvk5d/UZp9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N6NK7nP35d5qi5/8UPFZdCDpgwLObROGa0oQgOC1xYT4SiQmQbBDZbSJ/4A7ED6wWgT8wKpKgEkCfpkLCuHgb5gPyFVThmL2/j82w29mdSaZQtUyaXptVmW86RRWFAPEE38E/Flnwub638MrTYUL8JSNKKkVSdwbZV7t73KmnW4dZaAme1fIK+b7Zv5noVCC4OJfVmJr27u5bcsWDDtp33ca9NWDZgAqS1kUfI5fnEJozaWwdncyyCv7bWve2IsDdwXMXWaeBEFuTsbrbIgGDNlVtDhI3G4633rhyS3dIR9sPnx+9BtEkrrtap9pQakVl6L+1VJpJ/JuWY6wOj7+DRzMIgbcdmNml5QSwBIkqltK3Y690/UqPbaiFaVH493uvanLnkGQ13jwJBqTmkh8F24KxHNFojjelvEUpwCCbtwaAQlN5QhjX2ic8Q6tRqPpmAuNLJ0nIC98loFllykemLeOCwmBcP8r5pv+OWNsjXu8DyCdV+EJW82GgIkhuB5wR2WIa+eCvYqjp1x2u3K5vGnoVGHTWiRxfD2ECGQuAu+SqK/5dl1wXFYfvGiWDqB6Zr5HF97v6ECmKjpXHVFWow2o4MSPv/KBIOunpK5Re66SB4JEB68+ZRKlvXZN87Uqy4cYlArExXziShDU2wF3exBwA6lz3TyoNXzml47Q26fa86vMVukEwDbIDgEbT7pM+lIFH4A48+M0OupF3VlVygbZlWx7UfuzfzYLVZbxhh8OOLCjPZ9RvJsvxMDJ8tHTvDWfRxT2of2SE+6Ixa7LBWLTm0blUavo7GVM+ZGYuSlic0uWL434CM2awSu4TDIm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69faeaa0-76d2-4dd8-3060-08dba8183287
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 22:43:28.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9mLdfZwpqhYKDHSt82xKzTWReDlb1yNNze8qW5UedWw0kpUw2RxBThWgvq4dHktn4KPMDPmUWZxTtr+S0r6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=738 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280195
X-Proofpoint-GUID: -kkuHKeca4ff1xB6-kbccRaMNx398O7t
X-Proofpoint-ORIG-GUID: -kkuHKeca4ff1xB6-kbccRaMNx398O7t
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, btrfstune relies on the superblock of the device specified
in the btrfstune argument for fs_info::super_copy. However, it should
use fs_devices::latest_bdev, as it points to the device with the highest
fs_devices::generation number. This will contain the superblock updates
that other devices may have missed and we can now support reuniting
devices following failures of btrfstune -m|M|u|U as in the patches:

    btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
    btrfs-progs: recover from the failed btrfstune -m|M


> This lacks explanatni why it should use it, it's not obvious.

Could you please use the commit log above, or let me know
if a reroll is preferred?

Thanks, Anand
