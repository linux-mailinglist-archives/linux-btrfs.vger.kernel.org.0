Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CA4D297E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 08:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiCIHch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 02:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiCIHcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 02:32:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B805B2E3D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 23:31:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2294Jg4m010441;
        Wed, 9 Mar 2022 07:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H0S2132k+Vzn33WFgP/ig4I3pi9tzsmAImOB1EBAhTE=;
 b=sYALvdwYkNBXGuAZDrfSh0jC0pNNhmvbtdb0ql4lf5/lA8gDRxOEe4n8yl9RcMHqxqaO
 6WB3TqiUq18itFUz3x3AxofXM5ll2bP3g7pbqKezzweiLiZSzQo1ITRGPRUHYqwU7ZN2
 KTT68m2E5V7JuFl670sCeYVHlRLTcLe1AP73MDBPNENZv+V8lGQsF98F/e35qPOrTbs/
 5WNdWsPn2PENwEkW2NSgSm6OuC/UFPVeyyEPx3sOHVmjUiwq9+IF3p6om7IyiTbI5Q1x
 pb9CpmJgNaKUKXM6NH+tZctYWEGYugYrIbXSxUttearvnQKeSOEI1WzAKkNfvaXqOz3e Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrarvxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 07:31:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2297Grrb004576;
        Wed, 9 Mar 2022 07:31:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3ekvyvmfcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 07:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRvFzAptxxkqLdsoGO7PUMLnm20qkeqqopGBRelhbwmInVedrBNXbXx8HhKndwX7RnT+I9YkNfBUoi8dOWk8kSY9BczWtL0rHtGjl41SliP+z/KahcCToUbRW7F2eLkitfgQOvKyJvXTuLeuGmOFUC/phxSpjqKEAlKzxtRTk2dwrPFwzapVaXOKCeMLLKRSbzen5MM2vjcHnSAnSqmWLV2pa07+KHPKgjp0FcdbP3UyG7GJRG71uaN2A50jeEIKqaRS1kSxGS0RhHN485K+OSAiv8ZSaz82I2ZAsYCl+K48m8hpvYEwf8ffMbkGM5+c+K6xmnne/HtEr01K8vYnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0S2132k+Vzn33WFgP/ig4I3pi9tzsmAImOB1EBAhTE=;
 b=jBmpAteqKpcwE7rnCceZ379ulXOWme/gR6whFk0vOWOEbc3Q6TAINwNeZNPxhaHjZ7VeK2IWG+Tc1kIAH136fBaFcCpTGXZLfDifUwVX4Pc8ZAn1QO/xl47BjBpnOMbxbkEDnKy1rdpUKjFxb0EK7MSn/mr40q1yDkgQTlTXo26Z6h4IaushPMHe1kyMZ5mwuCjCb9HTstv8C3ebumcvy0tuJB3QzhhTuR4xyh823AAoRFm7h8WalvBqg++HjId0hQcL7hIFZ8hPI0zyX1MgLqEZ7QwfelMIgbTn9zOx125MDoiA+C18Yw6O+dhzNcyb0UyRP6tOjspoPQw9Csy69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0S2132k+Vzn33WFgP/ig4I3pi9tzsmAImOB1EBAhTE=;
 b=ZQNzWc0tSKVGqll6hCV/LV8Y1ouBEmU7yroRhRzKBLCt6afy5Xl4H+4RG8CDpc0vaIRQUT+s9Ne7+NuXOY1OdprjMvJ9pIAn3ZmYr1PQRTKGGmZctpgmkoQjyIF5+6QkMj8triXjq2dMVFnAidsNodcg3y/DinMQsmUkVR7EAE0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 07:31:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 07:31:26 +0000
Message-ID: <e9ca7751-680f-8f03-1de8-abfc232e0810@oracle.com>
Date:   Wed, 9 Mar 2022 15:31:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] btrfs: make device item removal and super block num
 devices update happen in the same transaction
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <b86647c31a09ccc44447367865ecac8d5b358b7c.1646717720.git.wqu@suse.com>
 <760da013-f15b-805f-ceaa-c8be838eb9ff@oracle.com>
 <899996b3-7859-5f3b-28bd-865dd8413078@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <899996b3-7859-5f3b-28bd-865dd8413078@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36456d7c-d9b1-46cf-fdc3-08da019ed1f9
X-MS-TrafficTypeDiagnostic: SA2PR10MB4507:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4507FC5A8AB6966A796E97AFE50A9@SA2PR10MB4507.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpQyhFFDnSid47bcqdq0KIALPC116u4uMBKEDOgg0cFvDXxitjZmMbHUa6BMrDcZljmToyZeX6ArNRMjQxPL4hV8zLyZmBJD5Wv3VuDaFhUFcEwjDEg/k6nBBKEoZWQqThyJWVoPoW1QY5ZE3hY+IlYyeX/1R2KMgejqKFnpOt4bockTREl5LZGvdS0HlmutqO0HIT55idP5JyAR9sBLPEKNIx/5kmQH/9U584pYCiODf0aK9n4IGAx0ACP6Fy8Gh1821GwGiDNet61dSZvJziypSM4b7Q7dFT++yEVfeCwcehTeX3bxpNqIuQkRI7ILYE6VskQXxthUS1US2s/Tg9uw3ph2tA5oFpvl7CJF8RWOWyH0mVESlZtkDU17k6JgNZb9RbMF4XdKbHDEoFUEjkME/QKZZISJzsyxffDZoD8LcBEYmFc1latnVvvwQ0l/iosMR+pTEwACkLT5Dg7q4tjR96Yd/YbdizsKHj8z4qD+bRJRjj2gYvcDrHin3uO2aSOvh7ZGALE9LmZlbdOz7T0OgA/KcvPEup18QTNBMMiZS6mTztN+NbM7YwOzyEzTItBWr/skM5C59jtXcOo8X8ekmust8PZIUGUcjem6NLo17/FKsFLnJQJxSNqW5b823N2sZCL55xpbrZFQ2ulrhvKpO61PYLqiZ/lkW7Ts22Ghz8JyZ55BlYLQ6mKuiiFlunPGZckkE36EkurGNY91swynQGACNknPqnvMblKuxsmsL/jKfNi2Y/3awS4Qck31FjCUvInnv7JRz21WjB5wFsUNt1vmpLGD5eDhxWfMzaLoR3oymnWx79RCLzdAtLja
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31696002)(110136005)(6486002)(508600001)(4326008)(8676002)(66946007)(26005)(966005)(8936002)(2906002)(15650500001)(44832011)(5660300002)(31686004)(86362001)(66476007)(66556008)(316002)(186003)(2616005)(53546011)(6506007)(6512007)(6666004)(83380400001)(66574015)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnQ1T2hsU0k5bVQ5L0tqSExWZ0ZHbzBESnJZM2p6NTJ1MG1QSWxDd0M3dTd4?=
 =?utf-8?B?Q2lpSEpOa1FCcmZjd1BYRElmSC9URDJPVHoyTVZDb0NSc1JIdjNvWVB6VjZy?=
 =?utf-8?B?YzhLcjNQZEZMeEppNHpHUGRoSTFrRVdMYng1bVJQY0Z3bXFxMXFRb0VCak55?=
 =?utf-8?B?M08wTDA3UHF3YlcyYjZTMXJBYUZaTzU3ZGFUTlQ1cGNHRCs0NFdJTUtPZ0lI?=
 =?utf-8?B?Z2VwRDNjejVEdXVOcXJpTXMzR0h3aDhvaE9Ec3drWmJhUmEvMDIyTG8xSVo0?=
 =?utf-8?B?L1BQQlBGUzB2cHNnKzQ5aVJQMDRYejcxTCt5RW5VdUk4ckhMRHNyaTJPZmdD?=
 =?utf-8?B?Q09EZ0ovWUlQclpjOGVEN0ZSWCtaK2hBZ2g0bkxCZXdSYlRtRnZjWFIvajQ0?=
 =?utf-8?B?UHBRc3B4T1E3RlVXSzdxeHhRdUJ5T1ptaWx4U0xEcTVPNjBnWHdIcURISmhD?=
 =?utf-8?B?UEVPMWxGOGdkcjFSdndvaXZza1FhQjZiR1JoSjV2OGJLZVNGTWpiTjl2Y0F1?=
 =?utf-8?B?Q1ZjNWhLcWdEN1VkcllIc2ZRSjREWVp5cEduT1E0NVdjNTB0R3BQWGs4VlJh?=
 =?utf-8?B?MnJSR1JyVmZSWmtIeFlRTFRiTmhUZ2JoSlR6dnFnLy9HNXh4bzg0THBqNkdr?=
 =?utf-8?B?U09HWjZGNGJkcFJFNnlBUTdrUTlCNVQ4bHBlcDRvMndacGxERFlxaVcrY2Rp?=
 =?utf-8?B?WHNhdExzbmNXOWdiOFZldkZPVDVSL3IrUHpGdm1Nd3QzSWprZmM5N1NQTy8x?=
 =?utf-8?B?UjNROHgvaGI2UTFyOXdmWnV3bWRDY1JuSE92UDc5SmNDUlp4TW9jOFRaNkJJ?=
 =?utf-8?B?Z1BIV3R0b0JOTmpYMG5TVjZ0bXcwc0g0ZHBaMEx3YlErWTk0dE5qOFpyVzZR?=
 =?utf-8?B?THJmNGpPcGJ4L3g3dERKdmVXeVcyTWdGck40dmt6N01GTE1MeE1NVEZGYUFL?=
 =?utf-8?B?TW5mdkRaL2FxdlNsWWljY0VkZjJ5Y1hxRkY5QjBZbXNicnBvcDF5V2Z6NHpX?=
 =?utf-8?B?K1JtS3hvVFgrL0Z6VXNWU205WDhXbGYyMGpDN0lJVENXTHVrT0lOK3ZsM0oy?=
 =?utf-8?B?RlpkUjlEVGl0WnJ4WlBsUWY5RlA0K0pqR2ozZU90NGNPdkRUNjdWUkdpaFNw?=
 =?utf-8?B?Ynk2aWpKY3FqSVVhVEJkZUd5dHozMnoyeGJ0eUtBdWY2cldLelBHZWRLREFN?=
 =?utf-8?B?L0RsOHBLb1BHZ2J6a21tUjRhLzVQOEhpdVBYZFhTRUtlVmxib3hFbldacHFO?=
 =?utf-8?B?QjNrMHpueVEwQ1k0dURMVFk4SzNsYURIeTl2U05ZcmxWbVNKaW9KcmdUVWhS?=
 =?utf-8?B?QTFjM2lBRzV0NkI5WnYyVWlVSGFuWEVqRFh5RWdSS094eWxzSVA1OTNPaXpO?=
 =?utf-8?B?RjROSWtodUoyTG5uZXphNE5McVhQVVdxaGl2NzRUZzlRVS9aaFFuQ0FjY3BC?=
 =?utf-8?B?d3F5ejR6VmR6ZTAxMjZUMUdKNVNSUzlOcjUzVCt0Mk1BYXA3bG90UCtoOU84?=
 =?utf-8?B?cmljSWl1VkdvTHk1RnVnaVdOQjltYXFMbWJ6OWF0ekd3U3VyWEVsV3ltdmVl?=
 =?utf-8?B?YjRxbHVDQUR6SzNtSld0NFFWZHJOa1htZ0xnTFJ1WDNOWFZoNFl3aE1ReG5y?=
 =?utf-8?B?TUhKbUJYWlBtbEUxWW1SdWpHeHNsYzhKbkhCZ3NUek1GUWtocGZGdzNZNEx3?=
 =?utf-8?B?RVlJYlNFL0VlV1VlNzdHa2tqeVE0Qll1UzVHVmpFUTBTb0ZnRnU0K09aWGZx?=
 =?utf-8?B?N2hlWmZUakJsU2F2SUFYUjJFSmxuNVlYcXJjWXpQM3FEMUNKYmdDSVJIV3d2?=
 =?utf-8?B?eWNJcEtQcGF2SlVsdnpxNjZ5c0hlT3psTHprVW9tWmEyQTlwZ3dWTlRaZW04?=
 =?utf-8?B?SC9Tdk83aWpvLytnSWMyWU5aaVl5S25sOCtaTVI3UmdZMHhrZzRPR3cwT1di?=
 =?utf-8?B?RWhiT3dRNmZHWkFUcnVtMkNzNC9oN1lEd0lXTFFSdG00ZDAzZzF2SVE1K0dt?=
 =?utf-8?B?T3oyb2liRjg0d2VVc3RnY3c3WnhmSk9nM2ZSNXNnRW9KYnZSUkRROWhKNUl1?=
 =?utf-8?B?Q1NWajRFV2toSVRlNDFFQ0dZT1oxS2c4cWdJbVI0Y2djaGZpbkhBM2dJOEEv?=
 =?utf-8?B?NUNtNWlSRENOVEpSeUJzaElzRzVLWGc1dmRyNVFXck1OVTZQeWsyd1dHSFJG?=
 =?utf-8?Q?cf5haEbnBrdXZAO4EILE0sA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36456d7c-d9b1-46cf-fdc3-08da019ed1f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 07:31:26.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANAvP46OvHck7O5VLeWyJc8lzS7UgCGoWi/p59ea50oQvf8eU4wyK2a51wL3qoHbgRQkXA+HiDWZ0S6o42E3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090038
X-Proofpoint-GUID: Tsm2FV_giFhw_7CxomsTb2Ck4x_-dsEj
X-Proofpoint-ORIG-GUID: Tsm2FV_giFhw_7CxomsTb2Ck4x_-dsEj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 09/03/2022 10:58, Qu Wenruo wrote:
> 
> 
> On 2022/3/9 10:12, Anand Jain wrote:
>> On 08/03/2022 13:36, Qu Wenruo wrote:
>>> [BUG]
>>> There is a report that a btrfs has a bad super block num devices.
>>>
>>> This makes btrfs to reject the fs completely.
>>>
>>>    BTRFS error (device sdd3): super_num_devices 3 mismatch with 
>>> num_devices 2 found here
>>>    BTRFS error (device sdd3): failed to read chunk tree: -22
>>>    BTRFS error (device sdd3): open_ctree failed
>>>
>>> [CAUSE]
>>> During btrfs device removal, chunk tree and super block num devs are
>>> updated in two different transactions:
>>>
>>>    btrfs_rm_device()
>>>    |- btrfs_rm_dev_item(device)
>>>    |  |- trans = btrfs_start_transaction()
>>>    |  |  Now we got transaction X
>>>    |  |
>>>    |  |- btrfs_del_item()
>>>    |  |  Now device item is removed from chunk tree
>>>    |  |
>>>    |  |- btrfs_commit_transaction()
>>>    |     Transaction X got committed, super num devs untouched,
>>>    |     but device item removed from chunk tree.
>>>    |     (AKA, super num devs is already incorrect)
>>>    |
>>>    |- cur_devices->num_devices--;
>>>    |- cur_devices->total_devices--;
>>>    |- btrfs_set_super_num_devices()
>>>       All those operations are not in transaction X, thus it will
>>>       only be written back to disk in next transaction.
>>>
>>> So after the transaction X in btrfs_rm_dev_item() committed, but before
>>> transaction X+1 (which can be minutes away), a power loss happen, then
>>> we got the super num mismatch.
>>>
>>> [FIX]
>>> Instead of starting and committing a transaction inside
>>> btrfs_rm_dev_item(), start a transaction in side btrfs_rm_device() and
>>> pass it to btrfs_rm_dev_item().
>>>
>>> And only commit the transaction after everything is done.
>>>  > Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
>>> Link: 
>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/ 
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/volumes.c | 65 ++++++++++++++++++++--------------------------
>>>   1 file changed, 28 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 57a754b33f10..6115c302f4ae 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1896,23 +1896,18 @@ static void update_dev_time(const char 
>>> *device_path)
>>>       path_put(&path);
>>>   }
>>> -static int btrfs_rm_dev_item(struct btrfs_device *device)
>>> +static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
>>> +                 struct btrfs_device *device)
>>>   {
>>>       struct btrfs_root *root = device->fs_info->chunk_root;
>>>       int ret;
>>>       struct btrfs_path *path;
>>>       struct btrfs_key key;
>>> -    struct btrfs_trans_handle *trans;
>>>       path = btrfs_alloc_path();
>>>       if (!path)
>>>           return -ENOMEM;
>>> -    trans = btrfs_start_transaction(root, 0);
>>> -    if (IS_ERR(trans)) {
>>> -        btrfs_free_path(path);
>>> -        return PTR_ERR(trans);
>>> -    }
>>>       key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
>>>       key.type = BTRFS_DEV_ITEM_KEY;
>>>       key.offset = device->devid;
>>> @@ -1923,21 +1918,12 @@ static int btrfs_rm_dev_item(struct 
>>> btrfs_device *device)
>>>       if (ret) {
>>>           if (ret > 0)
>>>               ret = -ENOENT;
>>> -        btrfs_abort_transaction(trans, ret);
>>> -        btrfs_end_transaction(trans);
>>>           goto out;
>>>       }
>>>       ret = btrfs_del_item(trans, root, path);
>>> -    if (ret) {
>>> -        btrfs_abort_transaction(trans, ret);
>>> -        btrfs_end_transaction(trans);
>>> -    }
>>> -
>>>   out:
>>>       btrfs_free_path(path);
>>> -    if (!ret)
>>> -        ret = btrfs_commit_transaction(trans);
>>>       return ret;
>>>   }
>>> @@ -2078,6 +2064,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>>>               struct btrfs_dev_lookup_args *args,
>>>               struct block_device **bdev, fmode_t *mode)
>>>   {
>>> +    struct btrfs_trans_handle *trans;
>>>       struct btrfs_device *device;
>>>       struct btrfs_fs_devices *cur_devices;
>>>       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>> @@ -2098,7 +2085,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>>>       ret = btrfs_check_raid_min_devices(fs_info, num_devices - 1);
>>>       if (ret)
>>> -        goto out;
>>> +        return ret;
>>>       device = btrfs_find_device(fs_info->fs_devices, args);
>>>       if (!device) {
>>> @@ -2106,27 +2093,22 @@ int btrfs_rm_device(struct btrfs_fs_info 
>>> *fs_info,
>>>               ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
>>>           else
>>>               ret = -ENOENT;
>>> -        goto out;
>>> +        return ret;
>>>       }
>>>       if (btrfs_pinned_by_swapfile(fs_info, device)) {
>>>           btrfs_warn_in_rcu(fs_info,
>>>             "cannot remove device %s (devid %llu) due to active 
>>> swapfile",
>>>                     rcu_str_deref(device->name), device->devid);
>>> -        ret = -ETXTBSY;
>>> -        goto out;
>>> +        return -ETXTBSY;
>>>       }
>>> -    if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
>>> -        ret = BTRFS_ERROR_DEV_TGT_REPLACE;
>>> -        goto out;
>>> -    }
>>> +    if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
>>> +        return BTRFS_ERROR_DEV_TGT_REPLACE;
>>>       if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>>> -        fs_info->fs_devices->rw_devices == 1) {
>>> -        ret = BTRFS_ERROR_DEV_ONLY_WRITABLE;
>>> -        goto out;
>>> -    }
>>> +        fs_info->fs_devices->rw_devices == 1)
>>> +        return BTRFS_ERROR_DEV_ONLY_WRITABLE;
>>>       if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>>           mutex_lock(&fs_info->chunk_mutex);
>>> @@ -2139,14 +2121,22 @@ int btrfs_rm_device(struct btrfs_fs_info 
>>> *fs_info,
>>>       if (ret)
>>>           goto error_undo;
>>> -    /*
>>> -     * TODO: the superblock still includes this device in its 
>>> num_devices
>>> -     * counter although write_all_supers() is not locked out. This
>>> -     * could give a filesystem state which requires a degraded mount.
>>> -     */
>>> -    ret = btrfs_rm_dev_item(device);
>>> -    if (ret)
>>> +    trans = btrfs_start_transaction(fs_info->chunk_root, 0);
>>> +    if (IS_ERR(trans)) {
>>> +        ret = PTR_ERR(trans);
>>>           goto error_undo;
>>> +    }
>>> +
>>> +    ret = btrfs_rm_dev_item(trans, device);
>>> +    if (ret) {
>>> +        /* Any error in dev item removal is critical */
>>> +        btrfs_crit(fs_info,
>>> +               "failed to remove device item for devid %llu: %d",
>>> +               device->devid, ret);
>>> +        btrfs_abort_transaction(trans, ret);
>>> +        btrfs_end_transaction(trans);
>>> +        return ret;
>>
>>   Missed error_undo part of the undo here.
> 
> Nope, that's exactly expected.
> 


> We abort transaction, thus nothing committed, no need to undo.

My concern is device->fs_devices->rw_devices
   is not equal to
device->fs_devices->num_devices
  and fs is ro at this stage.

I am a bit nervous if our close devices would be ok.
But it looks ok.
Anyway, after the unmount and mount recycle the
rw_devices == num_devices again. But a device shall have zero 
disk_total_bytes. Which is fine. The user can try rm device again.


Reviewed-by: Anand Jain <anand.jain@oracle.com>



Thanks, Anand




> In fact, after the btrfs_rm_dev_item() call, there is no real way to 
> rollback the delete.





> Thanks,
> Qu
>>
>> Thanks, Anand
>>
>>> +    }
>>>       clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>>       btrfs_scrub_cancel_dev(device);
>>> @@ -2229,7 +2219,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>>>           free_fs_devices(cur_devices);
>>>       }
>>> -out:
>>> +    ret = btrfs_commit_transaction(trans);
>>> +
>>>       return ret;
>>>   error_undo:
>>> @@ -2240,7 +2231,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>>>           device->fs_devices->rw_devices++;
>>>           mutex_unlock(&fs_info->chunk_mutex);
>>>       }
>>> -    goto out;
>>> +    return ret;
>>>   }
>>>   void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev)
>>
