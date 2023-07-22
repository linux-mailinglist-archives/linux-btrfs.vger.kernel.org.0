Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D475DD05
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGVOw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGVOw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 10:52:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E0E0;
        Sat, 22 Jul 2023 07:52:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MA18fZ032587;
        Sat, 22 Jul 2023 14:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Z3PsK7qAaYIWaHF/C5Eu/6NZpn59x75mGefYooAahDY=;
 b=sd2yw6EsO6l9xkCEvk8zv69bX5/xL1Oj4Tj2pKJyBBChCz5tjOjDg6FdG8OMKAvghcZo
 pQJGEdEycD1k7pvHdd6JNIxIJwe0LlNCmEHxz4b0nh2ErK2OHRLAaSaqIvxjH8ilyQj5
 KF2ZNkijz2+0hg4MPmrgqkAzF+hYw7SOwfU/vVQw2/Ma16y9W6usPHJfOUi47DASB56F
 i58B8Ovx039eiUyynGlFGaaSefx/Tm3UZySzmOY9U1hEKU+3WgCZxQ/58JcY5UrGwP0P
 qTLmiSr822R3vOPpIy5lg0+ZyeJRGb9zT7af/xhOV3gq8IlulEev9HETHHfVEyy8J9kD zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nugej1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 14:52:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36MEBAcO028393;
        Sat, 22 Jul 2023 14:52:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j85ddx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 14:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yek1adP3o+aHlRxWkB6WHRJ5o3iHWphLl2J4D61k1TX4WBDF4euYTV+66BgVuskjKYh1P5a3QEg3GhZlAFeQu3N2EwEf40boGf0iBKOWhA6JIjLiHw2ojXvvtD+nkCWdrbMlpWqwp17to4Uj+CxfbIAm/O1k4K7f4lUfWuBaYFJzHZcTpMk3x9SBjQjavAJT6DS46xWlIMfDIDSwL3x8lMFvb+eoWrP4DNF6EzT+13GDVZkHk0QlGj53u3SGqH1PSjHXosbcgkdd55CL5755ThTYeaQEo0ZKisAVWxXcVzpyvcX3z5qi1vTueP4xI053BUuTPE3C1RJCLLS271JO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3PsK7qAaYIWaHF/C5Eu/6NZpn59x75mGefYooAahDY=;
 b=SlDTjHBQTvg8/96uSQfKkY3V2ICDz0P+AUFstLgQ5zkNhvHd5jQE/ZMKDjcKDAxYdorPfWTvY1JBZwnUFyI0Kz26cfkfXEnt5FT186HmYAMb2K2WhDnFwKqiX/w8CgbjcJnVxZXbQnPGI8soHXbs+QDrORg/lgzW0VcWH+WUG/tb3F4tHkn2oeEzEtbQTL4qv7jl4jw/q7PKvLjzDpGM35PfT1QPqN2xcixsPwuuGIKu6lVfkrloiGtCINgZn97pmWG0Y46b+6ZYs6HDhV/xp4oC1p3ocznYQGymmfvVH2nsPwIN/dVzaa2dm2g5GlTugA+jqUvtnmTCQmg2x3hFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3PsK7qAaYIWaHF/C5Eu/6NZpn59x75mGefYooAahDY=;
 b=FHyRcOfR5W1UZoQoiIowAWKQbcw/9AEWqth3F0ueemSk6vpfrPv9VAjQEFLotZoBdcxqQgK0aQOe4kOWdje/qOOU9NpGlFxmvwU/lM4PIqWG4964uOom1p1gWP2Lla8FxijIiPytDfN3mg+psZ2rJ/NAPqLb1o9/s15MnDPuNkU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4232.namprd10.prod.outlook.com (2603:10b6:610:a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Sat, 22 Jul
 2023 14:52:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 14:52:47 +0000
Message-ID: <9a945fe6-f7b8-7ad9-29fc-a36eb80a63a6@oracle.com>
Date:   Sat, 22 Jul 2023 22:52:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230622065438.86402-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230622065438.86402-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b31223-e80a-4747-4f76-08db8ac34ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dG49IJWVpDIQWEDCNjIm1Ev5CIiuNbSPzcEnYaLhtW/BNuQa6Yqk/XeSI7hcW34fcw2ywLRMRqpheR6cEaSV1s2NCAzX+YRSzlLGUyBWSxd+RxmZgBvB9+Mp1YOZ+Ks3fCHA6vI+hXOYr5D1cHW8gTF/sAUCotOUVwlutBRnUDqaxo9gFk+Mr9kbai82gExQ1r187uB3YfJxt9v8hzum+U7KS3ar7soRk9U68ck3sdkCT4sLY7l0Wp0I8gBlSQPbhwjs4+PDSWFTXxqs3oxqEaL0VlPh/aXzJ9o8qVIWVpi/riUUJ2+CCnQ79k09CUeIXbHaUFxxipheF4gs16xRTq4p1KI87l+QWOW72P+Zv4irItzmDcXug1h6gNVfsmvUZU78QLu7A2cWfZAgBEnrEU8xSh2DvtOcAuE4K2o/LPEzCjjnCO5f2DO/0gERhjE04ni5sSBeyfSRkqzQukIYavvVOcuCnVtMMNygJ4ZcKBuiaSL35WYuWvP86cNEYR8dnBV38uR794PIG5uHJQzApIVopgGFym9OGDp1N6Ls28orMDusMqkMfh60/V2DuX9eIBa5jixL9n3YtyWptUxoMtsoWTDQksExy1EpgLRcjlCF3Z+8qRvhRAT+XLgi2QhrVK/jJTrnkY+ZOPJ3PuOZyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(31686004)(316002)(6512007)(6666004)(26005)(41300700001)(6506007)(186003)(53546011)(5660300002)(6486002)(66556008)(8936002)(8676002)(66476007)(66946007)(478600001)(44832011)(2616005)(83380400001)(2906002)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNPOHBGSWg0ZGJ2MnBpSHZIdnlKdlE2MjZWN0xFTGVCZXhRV3c2d25uN1VK?=
 =?utf-8?B?ekNlMnV4MUxYd1gxek1icHlaK2FqNEVyL0dWbmMzdzdtTkpRdmVPbXNtc0o1?=
 =?utf-8?B?NDlxbGpsc0RIZm1RZ2lSbzNHaFArYis3ZmxPaFg2NW9lUW9YVGo0L0ltY3N6?=
 =?utf-8?B?a1dCMm1OZjJKTXEzN3ZLVGMwZVdkQXRJRjkxdzZVbE8xakVOUndZemhGenhU?=
 =?utf-8?B?dkNVUHU1ZHNBenc2c0Z6VWh2OFlyK29pSFVvSWNWZy9uWWg0WUpqQThmNlZp?=
 =?utf-8?B?SmFreGpyYjA5b3VOeTdWNVJGTFpYVUpjSTFqY1JIQWd1TjFuNWRVZVNoRTcr?=
 =?utf-8?B?Z0g0M2R1M0pqbDJabHVscDE3VlFXWlAwTUZWamNESTAwblBuQjJ1RHlmOUQw?=
 =?utf-8?B?UEVZV1p0NTFZcUg5aGJLRTZHZzFObzl1Rnphbktxa1A1VmxHRWRwbEQxeTdL?=
 =?utf-8?B?bmlBdjYyT3UrWFdOZk4wbml4bjFSRTk3MVFvcDQ5WjRIYi9DR3E0RWF4MkFE?=
 =?utf-8?B?VWVEV3ZLSzZxN0tELzY4ZnpiVnM0Y2dKczRXRjBDeHl6eFc1a1ZKSnNBclpN?=
 =?utf-8?B?ZmNaRlZkNVFGK2hUTEl1L01XVWt3b25Rd3ZYdGVyekJkaUVFMll4dUkyMTlu?=
 =?utf-8?B?YjFFYkc2RXBJeFUvYjdDd2lubXVBSTAzSjFCalY1NkpsaWdMNUpxOEw3dlJE?=
 =?utf-8?B?ZFVmazBIQmlrcXBaN3JaYnlvQWd6RzVkbTVYY0ZyK09aTXdUZVNsMytOeDdX?=
 =?utf-8?B?ODlrSWtYdXVEYm1KbndXV01kcTMrK01rcWZvM01IV3RONFBYR3ljQk5wS05M?=
 =?utf-8?B?MnRJYkV3d0hqNk8wcjVWL0lVbUFaS1J6QWlCWENLRXkxUmZHMm1wTUFpVHhS?=
 =?utf-8?B?MG1uVTgwWmMwZ2Z3SUpjNXBlVWgyZ25WNGpkUXlQaVdUTnRvN2NvWU5mdGlS?=
 =?utf-8?B?bk52SFVzVGFVSnJoWGZFU3VoZXQ3Z3c0dVozVjAyNWRIbU9uTVduTHYvUkZu?=
 =?utf-8?B?NEdJU3lxdFAzL0RwK3V3MlRVcWQ4UGo1RmR2MnMvS1VoUkg3TUtVSzhkVWYw?=
 =?utf-8?B?OG5sajV0MWpFbEw1cEljMTY4dWNlbVhCcWlVWGZQc1A3a09reWIrakdmdWY0?=
 =?utf-8?B?KzcrY01tQVRqbDliQ2FaOHVwZ3ZaUUFaeUp4ZWJLMEtuQmVzNkg1Mk1PK3Ba?=
 =?utf-8?B?NG5CZ2hoS0ZKZkxKZU9vVDR3ekViUWpFWE45YWlXODlqS0NXSHF4TXlJMERG?=
 =?utf-8?B?aXZ0aU5MYVZsdlV3ck1ubzNuQU84NTV6ZkNaUjk0MnBSdW5JQU5NR2NzRUEw?=
 =?utf-8?B?N09VZ3M1SWg3V2RnK2VnQUxENGVNT0pZWHYzTW5KOU0vNGo3cjNFNnJhcVBl?=
 =?utf-8?B?ZkloNWR2THk3S3F3RFNnZC95c1Q4NzVWemkrNFc4Nys0SldRc0ZCVmZyZFdq?=
 =?utf-8?B?SEU5YUdubitDanZuRzVDaTlZSHV6dW53RWVXaFlMb1VVZ01INHdkaytTTHo4?=
 =?utf-8?B?K0xCTHlmbmlLWjBNTWhXOHVBeE4zUU5rdFBhZE1yWWJBdnhDbk5mYmdvd1Y3?=
 =?utf-8?B?VGRkY2hLVXpiaEFKb0ZGRkJ4S3F5ZmFCNUpYeS9VOU5XbW1ZbVRkNVlmRkNI?=
 =?utf-8?B?ZW9CdDd4aS9WRHQvRWdOdm5oV01rdElqNU5MU05LNlpva2hLMzE1akZJMlhB?=
 =?utf-8?B?MElDeXVLbVd0ZVIweGJ2alN3NWIzOXNNZUZZdm5QL3ZUeUNhM20xZDZPVjQ5?=
 =?utf-8?B?eFRLYll5WWU3V1MzeFh3czIwT1hzdGZ4SFlzOGxldzU3Nm9pb3hzdE56Rlh4?=
 =?utf-8?B?OVJ3TzlpVmVxUWlHSllQMG5ZSUhzQ0pnRkdTaTZMWGdBeTRYZW1WYnJHYk0r?=
 =?utf-8?B?c3MwZE9FSkNSbW5Ma0RweEE4MlNxZ3FxaDdkeVhwaTZtSVY4ck9CVVByYmIx?=
 =?utf-8?B?dDZPL1pWKzZWU1JMRURUNncvQlJBOUtjYzk3UTZTOVl5V1BGS0NvSnZleDNL?=
 =?utf-8?B?U2VjeXlwemZOSGxYV1pGbCszZ1B1NFgwczdYY2JhZ1d0TUN1VCs2dkNrYmNV?=
 =?utf-8?B?amNkS0hkNWJsK2sxTU1MKzI0U010MzJRdWwxdzgyU2doQjI5R2dFNm1kQzUy?=
 =?utf-8?Q?azTC5hTE4w2bCm0DsyAzyD06W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TQ93wnBIeYkOisNR6Xeg1wqA0IsjipHypR0ErcC7RNcNkOeZs15KhaFkPQZ5K5Jt041AGNLotjgwmY3GIMgpJ11rG67Asw5GSoRRV+gaPJxCFJvV3/j9JAfREeH+greMgq07u96nm3cPfJ0kEVUO3uTzcvlm2BbfMtqn9pgy+7/ZykaNsf0fv15QopFh4VoX7keLfvDIBiJqe8kIrJhczGzGwMiGzJd6af+1pebVxp7EwRnVGQGK6WqS9IKwRFX2gqnQliW0/QdQi5PSIparoRqwENS54phFGC75pyUg5piPqV/ksoZmboJEYJ92C9rZt+ZAn3IX920kDhPJwq/O4xqHhw2kfviEqfPVDFb3YpqSM3TN7O6rhvtijuTrSupO5IzfyuGvQvkL3Q1Fr/FdNkeOsYlSghMMTXsMS9dTcOHfgkbNb5iIZFNDWPIDiyhmeJ6VrCoJKA0oFNMUbA4PVOpZ6g8D305uqsub9Wy9WYrLlmHYFnA6MVOobcYwArwf8ANxkfD5RSKd4YS47z+QJ9VTdYpYUeHfWMAle/L51CePhtmc8/AHjSHPk+PbmF9+TNB3RvzzXB/59NttJgoebJ8aqPlFPsbJsREroC4u3TC37ve2b6e5qKWAsyzKRdgH/NnMokdoXEE/45YOQdLJmv/kEySLdnQXM7yuZIwaq/L5LSs+XSY5j9RHXrDOvmU38aBvXs0t4OS8vgBZKJugoLL28tDN/QpHw4iONRd4A4EPM6xbAJzDFkuA9ARCRNR1ofnFpv23y4jQ3CaGfwGXOMqlc5844zwSJQ81yhLDc2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b31223-e80a-4747-4f76-08db8ac34ff3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 14:52:47.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OT0C/tls0zGdz6AALTN0c0tKWkzpVzZQ0/lB2MfdqHmYo6w3MWdYnRocxZ8ck0EBNod2C/2q0MrjaihEPcuGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307220134
X-Proofpoint-ORIG-GUID: iP5WpG-RApW6GD0voHVMBLXa2UWcBjCc
X-Proofpoint-GUID: iP5WpG-RApW6GD0voHVMBLXa2UWcBjCc
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/06/2023 14:54, Qu Wenruo wrote:
> There is a recent regression during v6.4 merge window, that a u32 left
> shift overflow can cause problems with large data chunks (over 4G)
> sized.
> 
> This is especially nasty for RAID56, which can lead to ASSERT() during
> regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled.
> 
> This is the regression test case for it.
> 
> Unlike btrfs/292, btrfs doesn't support trim inside RAID56 chunks, thus
> the workflow is simplified:
> 
> - Create a RAID5 or RAID6 data chunk during mkfs
> 
> - Fill the fs with 5G data and sync
>    For unpatched kernel, the sync would crash the kernel.
> 
> - Make sure everything is fine
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   tests/btrfs/293     | 72 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/293.out |  2 ++
>   2 files changed, 74 insertions(+)
>   create mode 100755 tests/btrfs/293
>   create mode 100644 tests/btrfs/293.out
> 
> diff --git a/tests/btrfs/293 b/tests/btrfs/293
> new file mode 100755
> index 00000000..68312682
> --- /dev/null
> +++ b/tests/btrfs/293
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 293
> +#
> +# Test btrfs write behavior with large RAID56 chunks (size beyond 4G).
> +#
> +. ./common/preamble
> +_begin_fstest auto raid volume
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 8
> +_fixed_by_kernel_commit a7299a18a179 \
> +	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> +
> +_scratch_dev_pool_get 8
> +
> +datasize=$((5 * 1024 * 1024 * 1024))
> +
> +
> +workload()
> +{
> +	local data_profile=$1
> +
> +	_scratch_pool_mkfs -m raid1 -d $data_profile >> $seqres.full 2>&1
> +	_scratch_mount
> +	$XFS_IO_PROG -f -c "pwrite -b 1m 0 $datasize" $SCRATCH_MNT/foobar > /dev/null
> +
> +	# Unpatched kernel would trigger an ASSERT() or crash at writeback.
> +	sync
> +
> +	echo "=== With initial 5G data written ($data_profile) ===" >> $seqres.full
> +	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +	_scratch_unmount
> +
> +	# Make sure we haven't corrupted anything.
> +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		_scratch_dev_pool_put
> +		_fail "data corruption detected after initial data filling"
> +	fi
> +}
> +
> +# Make sure each device has at least 2G.
> +# Btrfs has a limits on per-device stripe length of 1G.
> +# Double that so that we can ensure a RAID6 data chunk with 6G size.
> +for i in $SCRATCH_DEV_POOL; do
> +	devsize=$(blockdev --getsize64 "$i")
> +	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
> +		_scratch_dev_pool_put
> +		_notrun "device $i is too small, need at least 2G"
> +	fi
> +done
> +
> +workload raid5
> +workload raid6
> +
> +_scratch_dev_pool_put
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
> new file mode 100644
> index 00000000..076fc056
> --- /dev/null
> +++ b/tests/btrfs/293.out
> @@ -0,0 +1,2 @@
> +QA output created by 293
> +Silence is golden

