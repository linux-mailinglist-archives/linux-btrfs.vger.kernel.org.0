Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE45F755A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJGIeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJGIeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 04:34:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5BB97AA
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 01:34:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2977CiUf031387;
        Fri, 7 Oct 2022 08:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=v86WJkJh37r4+i1M9Z4dPH645pPoT22oHcB4XoD+hjc=;
 b=AFQXnltNrHEoErnMqx13SXy9ucJKT+S14yj5SB1lNAMOVG3JLBKR1CBkVVxCqRyWHN08
 lhKJUjVrtYTfFVToN+rS7tu+EuInvvOgzK1Zngp3q0sr9Pqyf1VyZzKP4Ci0F/+Os9rW
 /OxEBj7u+iJimsaSANXFj1M2CvEDTsuDwfeK7DcB3Hb9GQLtOOjrRrF3ifD049NKkl9U
 uNpMcyK70mk8I7W500DtXJT675Mi6NO0rx7kO3xM++mfDPKTpuKqRxVzQyGhLqHHljwy
 A1hsogsVdlMlOQwTn8KxALAj+lKcfij8jeC2Aqa8gmJ0Ri4fPkXnxL3FOt7CSxvkVpJh cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxc526tkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 08:34:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29779vH0002632;
        Fri, 7 Oct 2022 08:34:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0cy5ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 08:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4fDhNgPhocuULz2OveHN004JYp6XN8rYyEcX1Ng+OLWwHbjeKhGdR4N+zB+AVq7MWRF3RsQHgT4ubibNx3rZcmtqZgTLXoNdK+7lrldU+70CDnc3H8s4+UOegelKhanjosFVq15v3aePaDC6+NdNevMo0axZoPRFEWOCztqYd46wf9eT8Kd7gf0NbBGjx3DaK6CXpRpbN8cglyw/uUoEjLmlwdXEa6Edz8f8j4ZOCspmNxgxY3uEK3HM9qeWlDwNQBvDt401Fr0flaQLVlCbqNQhD0z6kiUGz24A4u6U6ie+qAj8hGRVoTgDpfzXSvqvzJJ7f5A07iLeKy75iq3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v86WJkJh37r4+i1M9Z4dPH645pPoT22oHcB4XoD+hjc=;
 b=obd0tQL98Tuljpclw996am7KgxmpHXM1J+MqLG70ajrRijk7UC2yK6HK9c5evSM6qBb4Uk/hO0zSPbA9EHJML/6SYnrCCrxEGKPNkSuXcT976H5CYd2ECLar6CXXNhO5tw6ii4l9CZmJrRz04sOn3ewiX3O7BYbFDcv3TA3n5NBjGF22Y+wLlBOin3Yv8KlWbc9ih6ay3nNEv9DfwvIsOrVTkm7TDbj0yHWv85DxRtWX07lebxnv6ZQYSnCajNmRVjl8VRdz3cguHZY8/SE4kl2XPiBTjg8mEikJ3OU01uBTqoXEsW05DiRMF1uv5DD5EAo7V4CW8V5FVROTplPuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v86WJkJh37r4+i1M9Z4dPH645pPoT22oHcB4XoD+hjc=;
 b=ckQGnlJUFJGm/iogpGp6GkgFbil1MV0KIUeEuNf4AmUANi7Y41SnXm9K6NzxPcb2D7OUjpY33pNCe/qVyzQc4CB+x4mlSHV12zeA/CXFkzTgqOxgOU7jcf3pWkyhCRdoKWuKIY0BZkxSy6WRJGhUoyyH5xP+XQLSyx0OEUMSSVM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 08:34:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 08:34:06 +0000
Message-ID: <ba25f7c1-f469-2e51-7671-a0c79303b976@oracle.com>
Date:   Fri, 7 Oct 2022 16:34:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4] btrfs-progs: fsfeatures: properly merge -O and -R
 options
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <6df72bf7175552fb966a9529783febdf62bce971.1664934441.git.wqu@suse.com>
 <20221006151811.GM13389@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221006151811.GM13389@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b225f8d-e3af-4b04-62cf-08daa83eb25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xk1xknIJLdM8ZCDz0+7sjzsP40RuBBSR/cWyJ4XkiWHVDDLGJK8mWB9/Y7S3ki1mNek7YvtQaRJ5jVLeAjjRvjsCkdwh46eLD3Ng/CKBVr7B69slmHICrjY0ufQqcaosRFiEHUDBMvfbME9iaV0iF/jaxYlyuJPkpZx40vLE3EcerI7cP6rJquY5SFiWR+ad75l3ZeXyeamS4+7gD3YE8x0d8RyF+mjE1KBKYgk0Lt4ZBR2bRf8qg9HQV491ANIcJDAWcCwucqGpZQs48G0eoFCvfOm8LZXq0cJI2D3TRaFQgJfLTo4v3s55xmIfeMA/2T/1rTxSfavSqBnq1+3BYwy36Tzs3Ugto1TGhjbEyZCV9pASzatqgDySyIg9qW3V75s89ZrshfMgSEMxV+7ewfL0Mg0TFR8jGerMeK6Y2My/YRDOiuo9qfV4I9r3uooSjpK5LPsihv0hgg2Vi8kuZ0QbB+RxegCGtQ1wj1waRd+zY9roboGu3G/vFEkz5YPPWqKEsCt0uRvGXNRAJvNWwWOS68TrP/eS3kd5SrtDV0gNyQPcdBFbCieJLZq0Df2sQ6PeDl4H682LW7OF8+z73mZMSFVXnwGjf3beGYUxNB+pG3Es9I1lyCW6RBzF4Ddw+lAxHwSg0eKDyWGeRMRA7FUvbC/4WzsZx++jff3Kqvj6L5Fse+dKbbZELvnTxW+SsdTufbMWPXVcc6LW2mPontEpVEEtfyjoD+x8CuxUxnUo47qc/hdCQKf6iSi8mpC5Vqtsaq97iufY7JSQnrDDfOT8coD8d7Uk/dJp7vyJ64V2bZXzX4iCIWJ2AK0f8has
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(2906002)(44832011)(5660300002)(966005)(6486002)(316002)(36756003)(478600001)(38100700002)(66946007)(8676002)(6666004)(83380400001)(6506007)(66476007)(6916009)(66556008)(4326008)(86362001)(2616005)(8936002)(41300700001)(31686004)(53546011)(26005)(6512007)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG9RN3M4Sno1cm1KcUhlbFRxVFA4WHYxTEFrME4wZmNvc3YxbHNJQys5VU1J?=
 =?utf-8?B?VHlLZnZna0xwR2VuRkZSb2loUnhKeWV1STNYZWNwbU9qLzFWRUFFaTZWMW5F?=
 =?utf-8?B?aDdTNTM2cnhDSXN0UjdWc3pUNEJVUFJxYTZoOHV3SnBwNXdUeElnMCtwNmxE?=
 =?utf-8?B?L2RTbEpNMnc2UkJubjhQNUN3enBqVjQva09hZHVzSUJWRHRZelpxV1UvNXpZ?=
 =?utf-8?B?aEVwSVBNbU5YTDlMQU40TExlYVB6ZUtuZjJySjZFTzYwQ0NEU0dhTkZieG1v?=
 =?utf-8?B?RVpVK2o2SFYxNWRNWFRzdjA4ZldYSnl5Z2JwSlZMWm5ya2ZNWko4a2RycHFN?=
 =?utf-8?B?MTY2SzhELy92eFNQeWhtaXVBc3RLajJHTVBIeXhOZVB0VkhxenlkQlA3VHBY?=
 =?utf-8?B?NWl5bTNiRjlUem56aStzOVZDOVBxMXdPRUhGVWtyQzF4aUV6eTRQcE0ycnpJ?=
 =?utf-8?B?aTV2c2kxVDFFRkFBRlVWZmRKTTgvMkNsU1Y1a0lycnpKd3ZxL1JZZ0NaUzJ4?=
 =?utf-8?B?WStnei9Td24rczRxOVhXZG5RRUFGSHdDMUlxRXNvTG9UMExDdkd4MlJoWkZw?=
 =?utf-8?B?Z3NnQ1ZxcktSYnZNVXNtV1YwMWFFVyttQmNITDlveHJBQ25NalFBaGhQZXRC?=
 =?utf-8?B?dnNtYnhjSjJ0SFBCMzZqUThBd3l5MFY3RlZBN0tsbDNUNzI1Sm1JMHhyV1N6?=
 =?utf-8?B?bERTbXh3cUFscDZIUVZSQlVNcDREdk1wN1FPL29Gb0haVVR0aGwyMmlKeGI0?=
 =?utf-8?B?VnJzUWlHTnUvc1JPSi84VUtPQVJONHFVaVgyM01qcUptS1VpT1A5a1dwVU9i?=
 =?utf-8?B?R2VxUWVKZjdLcjF2NWo5dStqVWk2S1I1UWtJbTVuN0tCa1pSUEduOVhPNERT?=
 =?utf-8?B?NXVYbFBnUXk1ZjcxYzZzbktkNVVaTVR3b3RvNXZIcTZHMHJXQ2N1WU9lWGY5?=
 =?utf-8?B?cTVjUFprL243TlF4ajdXeCtiTjcwVjhRZVVqc0c2c3AzZTJ3ZDdQTktmWWsz?=
 =?utf-8?B?by9peWRuc3kvcjA3eVdhb01XSGYyTWduUU5BQW50VWdCV2lmbkdmWW1GK1c0?=
 =?utf-8?B?UGYxaG1hbUI1VFFqMjBNSHdhY3VhNGFmUmpjakNyeUxhK0N4VTlIb0s4bk4r?=
 =?utf-8?B?Rkg4cjdXYzB1MDRUb3B1ZVpSMElnd052bE5pcXdXRVNRMTh2Ukh2RkpLWXhv?=
 =?utf-8?B?RGdVenBxeWwrcENoR3RFQlc5dGtGcmtzZ1RFd0JJMlRuZkVJa0o3TlA5djZl?=
 =?utf-8?B?Yjk1cU9WUk5zN2ZEZ0hYU0dxWUFlYlRaaXdPUTlZTFZwaXBhMzN2a3VCQXJW?=
 =?utf-8?B?M01BQStYcncxRHFUdXFvZTltejZoNmxybWZEblJsSU5vcW5LbHA4UmVGUXZQ?=
 =?utf-8?B?NHJsMGNDVXVtUGJlMWloV3phR24xV0RvTzhmTXAyRGltUXVpbnkvOTNIeGpr?=
 =?utf-8?B?Yy9WeVVwQ3VraWdsTG5IUzhXbmxmQ29NRFZzSUlUczFoYzFKc0w0ZXRxS0lT?=
 =?utf-8?B?ZTlEYlRqMWc3VE9vcFZpTU9oRlB1aDRYM0ljVVJVazVHUGl4QVR2Y1E5SFV6?=
 =?utf-8?B?Uzl1eW5la2Fvb2hvRU5rWkVtMnorbUxJVVc5dkcyM1U1cWlWZFFjNlRpQThl?=
 =?utf-8?B?aHBVMzFWdm9hN1gxVStoVUNPNlF1Sy82bHdYS284a0ZiMFpsRkxseU9LT3oz?=
 =?utf-8?B?OWd6dFlmMjdzODdSait3eGNqcnpLR2RTeTlEOHU2RGNKMUp0enNUNzd3UDlD?=
 =?utf-8?B?dS9Ta0pHK0pJbVhFRVhxdjJPSjRwNUgrUWF6Uko5MTU3cjFXQ2pBOHJxREdR?=
 =?utf-8?B?QU5BUGdBdldzVGMydnhTeUpNbGJuUHdlZHhXbDdoWElydG43UEJYV1duSmVu?=
 =?utf-8?B?NWJBV3lpNnlSb1JDYVlmREZ3WjJKNlFSK0ZQK09NaXoyT0EvUlRvRUplU2Np?=
 =?utf-8?B?a3NQV1N3UktsaFpJUDVxOGNuRUNJaTVaeHdHdFA2dU02VHA1VC9BQXNOcUZ0?=
 =?utf-8?B?S0dJRTJmeDluMFRzUjNjcFJqZ0VqUU5KTlczS0dUREtNMkpqTytOLy9uZHNz?=
 =?utf-8?B?NGhORUhQaGFGMEZpV2N6YTF1NTd6T0VLNFpPZjNmSzhEN2w1c0xJUGhtdkh1?=
 =?utf-8?Q?qft/EOFDaSs9hcFoSPWV3k9Y7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b225f8d-e3af-4b04-62cf-08daa83eb25f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 08:34:06.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAztvF87WrQa0NgtrVBevo1LZLGs9b9M9XtitUVpUNoPN/m3j3+OERTFuRpVs9Z6+VlB/Jeo6E085HboMa0h2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070051
X-Proofpoint-GUID: 8bs9v98h1H-TMReQEou7__bM4Rqm8Hh1
X-Proofpoint-ORIG-GUID: 8bs9v98h1H-TMReQEou7__bM4Rqm8Hh1
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/10/2022 23:18, David Sterba wrote:
> On Wed, Oct 05, 2022 at 09:48:07AM +0800, Qu Wenruo wrote:
>> [BUG]
>> Commit "btrfs-progs: prepare merging compat feature lists" tries to
>> merged "-O" and "-R" options, as they don't correctly represents
>> btrfs features.
>>
>> But that commit caused the following bug during mkfs for experimental
>> build:
>>
>>    $ mkfs.btrfs -f -O block-group-tree  /dev/nvme0n1
>>    btrfs-progs v5.19.1
>>    See http://btrfs.wiki.kernel.org for more information.
>>
>>    ERROR: superblock magic doesn't match
>>    ERROR: illegal nodesize 16384 (not equal to 4096 for mixed block group)
>>
>> [CAUSE]
>> Currently btrfs_parse_fs_features() will return a u64, and reuse the
>> same u64 for both incompat and compat RO flags for experimental branch.
>>
>> This can easily leads to conflicts, as
>> BTRFS_FEATURE_INCOMPAT_MIXED_BLOCK_GROUP and
>> BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE both share the same bit
>> (1 << 2).
>>
>> Thus for above case, mkfs.btrfs believe it has set MIXED_BLOCK_GROUP
>> feature, but what we really want is BLOCK_GROUP_TREE.
>>
>> [FIX]
>> Instead of incorrectly re-using the same bits in btrfs_feature, split
>> the old flags into 3 flags:
>>
>> - incompat_flag
>> - compat_ro_flag
>> - runtime_flag
>>
>> The first two flags are easy to understand, the corresponding flag of
>> each feature.
>> The last runtime_flag is to compensate features which doesn't have any

  I read the commit 5ac6e02665a6 ("btrfs-progs: mkfs: add -R|--runtime-
  features option") too. But I still can't comprehend the problem that
  the runtime flags solved; because the -O option enables the same
  runtime features.

>> on-disk flag set, like QUOTA and LIST_ALL.

  LIST_ALL is not a (kernel) feature.


>> And since we're no longer using a single u64 as features, we have to
>> introduce a new structure, btrfs_mkfs_features, to contain above 3
>> flags.
>>
>> This also mean, things like default mkfs features must be converted to
>> use the new structure, thus those old macros are all converted to
>> const static structures:
>>
>> - BTRFS_MKFS_DEFAULT_FEATURES + BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES
>>    -> btrfs_mkfs_default_features
>>
>> - BTRFS_CONVERT_ALLOWED_FEATURES -> btrfs_convert_allowed_features
>>
>> And since we're using a structure, it's not longer as easy to implement
>> a disallowed mask.
>>
>> Thus functions with @mask_disallowed are all changed to using
>> an @allowed structure pointer (which can be NULL).
>>
>> Finally if we have experimental features enabled, all features can be
>> specified by -O options, and we can output a unified feature list,
>> instead of the old split ones.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix convert test failure due to missing allowed features
>>
>> v3:
>> - Fix a bug that we can not unset free-space-tree for non-experimental
>>    build
>>
>> - Fix a bug that free-space-tree compat RO flags are not properly set
>>    for non-experimental build
>>
>> v4:
>> - Address David's concern of new BTRFS_FEATURE_GENERIC_* defines
>>    By introducing a new btrfs_mkfs_features structure, so we don't need
>>    extra re-definitions.
>>
>>    The amount of code change is still the same as v3, since we have a
>>    larger interface change.
> 
> Thanks, this version looks good to me and maybe even better than what I
> intended to implement myself. The amount of changed lines is high but
> the core changes are clear and the rest is API update. 


> Added to devel.

Still, there is something to take care of, I rebase to devel.


$ mkfs.btrfs -f -O extent-tree-v2 /dev/nvme0n1

ERROR: superblock magic doesn't match
NOTE: several default settings have changed in version 5.15, please make 
sure
       this does not affect your deployments:
       - DUP for metadata (-m dup)
       - enabled no-holes (-O no-holes)
       - enabled free-space-tree (-R free-space-tree)

Segmentation fault (core dumped)



static int cache_block_group(struct btrfs_root *root,
                              struct btrfs_block_group *block_group)
{
         struct btrfs_path *path;
         int ret;
         struct btrfs_key key;
         struct extent_buffer *leaf;
         struct extent_io_tree *free_space_cache;
         int slot;
         u64 last;
         u64 hole_size;

         if (!block_group)
                 return 0;

         root = btrfs_extent_root(root->fs_info, 0);  <--- root is NULL.




