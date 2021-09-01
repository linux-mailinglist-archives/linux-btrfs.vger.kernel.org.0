Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26B53FE4FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 23:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbhIAVcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 17:32:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8662 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245467AbhIAVcF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 17:32:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181I4xOj004476;
        Wed, 1 Sep 2021 21:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SrKj4gPqLKVyOxACKWgd+1F9UvQIVbNc2iA9MOB8g1g=;
 b=PUzwarMicWOPJq/Bd/oCv0RjJLJ5hxM2l7kA8DjjE7adbLUC/TW6d77lcN4hevXHAgn2
 bDWKIujwFI4nSQiczH8VGcDcYc0sRiM6zT+DdL3oogZooUz1NjhhGrUi95l9V8fMpUrz
 Km79/hr8L2perculgguGCDNv1SkjtmQ22MfZ3726IPvgYTVSVDz4t2EtTC3hxGPr8yLE
 QDSk3G88kRO9xq3nK/rMuDiirEVTBVNUREWCtBXXWLKDkg/aL24zS/eIhXk04ekjBnM+
 OoPo9Sm+tTGB94vDtEef5ZWF6kXEJjKKXtobH1Z3uOHqDJyRdKngun1+aDVchH4l/MOC SQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SrKj4gPqLKVyOxACKWgd+1F9UvQIVbNc2iA9MOB8g1g=;
 b=fQY7LBmbndLZwNs6w68oRIjGOj3RA/orHdBgBexy1MEmIrVRgDFq0NxR2+t3KRy8wB65
 07haRcBbLHNtzt+WFujcVqIPEy95tudgFjMA2YgNAuPqmv70qpceqZAq/ZloSGBpTapb
 gRX/g3fT02KShVM59iXvJzEaJo6wWccFEKrVgeFECIf3N9mlltTeZtM/GP4W3wDmLwdU
 0KMihhCG2ZoiGuWTknZaiaEiQjSrwE3PG9V0gFiB1D0QBHJEYwRL7ZVdTSU9rjQdeNJo
 HYbQ6HnuHoGJPTqpq+389aL/MAuquuwCaqryxnhonB1m1t+sdXcihPb9oIdX7RXBOiXH qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw18mn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 21:31:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181LTltX110304;
        Wed, 1 Sep 2021 21:31:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3030.oracle.com with ESMTP id 3atdyw15a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 21:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=horAj8Pe/yEMAckHijBLXGRmsc86Grzbhdy7FCHzgbRqK5yRwhytxYJkFNSxBUWU6Y5RYV+BNXVlef8G4wePLNvgnyf/9rXB+hxXt3ZtrqdCbmXA/dIJG8wjkaREcPe8Wl6ZbPX7kFiWPYx0AomGhWz6T57OEft43Yga651RbJ8r0swtMcbvLr1HBGgJSUzZyF3dWmGTVkyNif3L/aO3qNigYqsqFPGUoAiSM+bNa9xBJLHhX1yNlE4zR7AfC0KX/DFBln/aQuakCkMdRLZW74KxPWkZ9l8LdBFoJCPXEPm5da3fcA3bea2lQAqY9WL3bf+5KX6Mz10ksctoR/0UcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrKj4gPqLKVyOxACKWgd+1F9UvQIVbNc2iA9MOB8g1g=;
 b=Qwpa0pBGY4827lOggpiMN4EZ3s0A+Ee4UrHtiPpARVHxeWFnF6o1VtxxjLY233VHUVLhQVM3etzpx4ezxuRTMgz8u0k6O4EDhl0siGGB6YBoEjGZB//1fCrCNQ39Ctfu+e6SRCImDxu2Bc6CdPosj1IPRSMMjo8vq2Uvqmra5asVzdy7PfQBd/oY/Z0Fy2SuUAaKTm7IDg36z1/HjBuEGoXglQpcN55Fks6NPRTcjj6kO5AgCR6KYtYSyWviub6J3TFtuN0/7LEUdD8maXgt7E5Uu/NOtRwIJS5lMO/A9bpUaRFwAg+wYh/egYgvWmsC9VZeDM6ZHbZY6IVTppYZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrKj4gPqLKVyOxACKWgd+1F9UvQIVbNc2iA9MOB8g1g=;
 b=ywrGaRBuw2vrizNzCSk9DaKbsIOIllxtp+66m4GX8OyV3VCjy3dR+0YCz0U1dJ1aVThL2ZXmTf6oFBADCZSUg3ek3Qvgwk1escQ+/5ssklZKOgyCR6ngSOY5DoVwQ19xUlD9tTXTrFIv1PEMgAHH6tu8k1fmUceEiWb3QesGjnk=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2963.namprd10.prod.outlook.com (2603:10b6:208:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 21:31:01 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 21:31:01 +0000
Subject: Re: btrfs mount takes too long time
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Jingyun He <jingyun.ho@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a0990c37-0b94-53e7-051e-ee7667c4bc94@oracle.com>
Date:   Thu, 2 Sep 2021 05:30:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Wed, 1 Sep 2021 21:30:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa28262b-1ae0-4deb-ef54-08d96d8fcb66
X-MS-TrafficTypeDiagnostic: BL0PR10MB2963:
X-Microsoft-Antispam-PRVS: <BL0PR10MB296334DA9AD924814C1DAC54E5CD9@BL0PR10MB2963.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/4/XZzJHJHeC+cjMbQmUaMtTdMk9pqAF5O0gGMLwwTDXYlkyHio7HhbtApK9lTVQpqpvfrUmuDgUyvYbSUpoUcZlfNhk39ZtwFKR8IJFcGNkMan4zfvHTQUy76TQMIOTloaG9VigA2dwbWh8F12mSJ/EhyJH2Nx8KLjt1zjxxAYWWYqP0dEwxk5gA5mN3fn4J2ln4zGnE+0NzcFRvt/8RZididE2+dWgutauZTd8e1kp8fUREsCmkZoeLXI1I15y7LMN8BSNEP5XQwce/p7YWKWzTD/o1/gH6KjEoxhx/d03vPBtrXX1mnEk2cZfDrU+qQo+Y1yTszSG/v4gmWXopjDiY3mb/AZ/Tn/fQqUXBpNjZdRFpKBT0JLP4XIMT0YHoW8h1Mgiq2xXSZG0irSe9dC+E7Il4pMBet+wrirR9kYZk3264Orvmk2H3Kg91DF9Fxz7kQ4MY3pFOE6Y1uceb/bATWQrJseK4e2VPzpDc/4bPwWKqhxGGrEzdeoU1VbZs/Bzc1QWdr9/tgnAGs1yfUGan9x9AReVIku4Do7wNMKLt1smrXEYHZtaQXRUhIkWtEsF4K32ZCdR40RESd1M74GsZh/r7IDoodBrmlajUZlxv68dFyCSjsCgcRlZuXuPzexx9suTCvq8HukItrVqs4tDLviGuz5clRf/Dbt1f/dR7bBKC2lzWmEEq7fn55ZmEPUQn0zM8DLKtormRkpnN2dpOD3UB0Yw9YVmljX5GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39860400002)(66946007)(66556008)(44832011)(83380400001)(6916009)(66476007)(478600001)(2616005)(53546011)(8936002)(26005)(186003)(8676002)(86362001)(956004)(36756003)(66574015)(31686004)(54906003)(4326008)(5660300002)(16576012)(38100700002)(316002)(966005)(6486002)(6666004)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpIbWMxRmRzcUJjSWoybURrUTdFTHFrY2N2ZzY0MTYzZ1p0MmZIRjNHL2xo?=
 =?utf-8?B?Ky9EWUFLd2JNSENUUWdHR3kzUnlkeXJISnBLQ0tjRHV2bEdwME5yV0ZjcThV?=
 =?utf-8?B?aStUOHRTL25OaGJwL2E4V1NPQ0l5WXBSdy9XNHZKZ0lLU1ZuOWJVN3lXL1NB?=
 =?utf-8?B?RXJxdEc1d1VHTUJPTTR4VFhudGFXQjRmdC90RjhRelBFWVAvelBYV1F4dTd2?=
 =?utf-8?B?UDNnWkF5WUtpKzVLUm5ob1I4Zmc5Q0V3U0Q2Wk5wZnhHYXpSK3hZU2cxLzBo?=
 =?utf-8?B?VHEyWTRuam5iSWpTZE91S1QyYi9oV0dTcXpIVm95Q0l1aFhEUy9pNzhtNEdM?=
 =?utf-8?B?Si9tNU1pcDdkYUQ3YXVucGRROWxHRDdUdkpJSjMzL09ZTWFQTUhMZytvWmpE?=
 =?utf-8?B?anZWaDVrcUszQ08rZnlrQjgyQVFHNk9IL002aGpzNVpqbVlhclVaakpJK0JO?=
 =?utf-8?B?ZFJ3RnpmLzE2cGNWbXlvMzZDRWtQZFJBNmp1dCt4MFpHbnZyRW1yb09qQmNC?=
 =?utf-8?B?SjQ3a01FNFpwdnBuNjBMMUVUVlF4eUh4OVZiMkI5Yk1lZERzd2dvcGIwb1Jj?=
 =?utf-8?B?NGI2Wk94bjR6aWpkTWhvOElCMW1kQk9wSDljdDd5ZlU2VnljNFdXeFR2ZTEr?=
 =?utf-8?B?MFV3b1JySCtwRlUxd0drM1VFb0VpclFLNGNXNzlOQURmQjlKYmZ0QnpuUnpF?=
 =?utf-8?B?NUpqNCthZ3NGVHZGNlFjenNsam9sRUFmOGRESnVsNnBKK0VnWEt1dXRScUtS?=
 =?utf-8?B?V2NwTXQyenJvV09UbXVPeVRzaytKVVRLa1hLU29hV1kxTlRWei9jNjZNSnIy?=
 =?utf-8?B?SEJ4WEZES3lmN29idktjYzh0eFNFc1FHNDZ1Tk9zckFJcEw0THNyRFkwUmFu?=
 =?utf-8?B?V0dSTTFtMDdSKzZkbFFnaVFDeUxaMm9KNm9tYmRVZ1ZKSDFYZ3JQUjdCaGMy?=
 =?utf-8?B?a0xQOFhUckhXZzFNRmo3TGU1d3dDOHFybE84UUV1UEtkcUpPM1VycVVmR2NZ?=
 =?utf-8?B?L2lOaU8xamJ3ZjdWbDV0bEtudTdMb0R4YkxjKzdHc3poSElZS2dBTkNONktr?=
 =?utf-8?B?N2lNRUhiMU5EblpTTmh2MUhWejdDczEvNTh4b05RU1p6elV5SEgyV3l3UGlR?=
 =?utf-8?B?KzJHcTB0K0d0dG1KbmZyVWE1eUQ2dk1FQzZ6Y2RHZUdPQ0g4b0toTmJuSHdC?=
 =?utf-8?B?elFjUmtZNGtNNjBMUVZ1eUpZSVlYVDBmWlhVcUlia2FqKy9wVE1NbVU4Y3E3?=
 =?utf-8?B?VFpDYUpWSVk0R1VpcFJmNHhFaVY3TmR0eFN2dkZibGEwdlFlK0V3WnduM25t?=
 =?utf-8?B?U25SMWR4V1hMYU9WNWhzUVR6U1JyVnBEVkMzaGtPOFEycVV3Qk5GVW11OUJk?=
 =?utf-8?B?eGRqbmx3cldNMHRhYlprTlpON1Jrb0Yxa0svYUdFK2NyR3ArVE5GaWl1Vnkv?=
 =?utf-8?B?eG13WHpWcFZmNVhNWWoyd1pyaUxPRVorb3NSOE5XeU5LQWNuMkN1SjdJY1NN?=
 =?utf-8?B?aGVqUHlwNlFmRWFCM1Y2YTd0VzI1ZEJNd1lYcXpKR2lndGZqR0lXZ1k3ZGxl?=
 =?utf-8?B?SWJlang2TFRhbmlTY3l1eGs5NnZrVERzcHNtNGoyQlFNMTVMNlYwNWpTTFV0?=
 =?utf-8?B?SzgwU0djWUxQQjlTTzgrNG5TV0VPb1V2OW1YeUVwQTBjZnFhQ1NwZFlYS29M?=
 =?utf-8?B?dUFZTU8rd1A1eTFrVVg1R2dlWTNWbGdxL1RGT0RTRUVVMkpvZ2VoS1p4RVMx?=
 =?utf-8?Q?SiCgpbxRW5Uo8tg8OCnIBc3PSjrdXv8Q6NTCqGv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa28262b-1ae0-4deb-ef54-08d96d8fcb66
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:31:01.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZwTUT/DRxPWGD9/fepe36vd0Sh8VGExjwg4gOl1yIKU7zi8e1a7XBwU8ClTthR29oTI9Kh5Z91quLU69QL3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2963
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010125
X-Proofpoint-GUID: VInGlfwGvY9oUfX3W5rmCw1jMLmOv2va
X-Proofpoint-ORIG-GUID: VInGlfwGvY9oUfX3W5rmCw1jMLmOv2va
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2021 00:11, Dāvis Mosāns wrote:
> pirmd., 2021. g. 30. aug., plkst. 16:08 — lietotājs Anand Jain
> (<anand.jain@oracle.com>) rakstīja:
>>
>> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
>> was taken by btrfs_read_block_groups().
>>
>> -------------------
>>    1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
>>    1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>>    0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>>    0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>>    0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>>    0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>>    0) 0.865 us | btrfs_discard_resume [btrfs]();
>>    0) $ 228254398 us | } /* open_ctree [btrfs] */
>> -------------------
>>
>> Now we need to run the same thing on btrfs_read_block_groups(),
>> could you please run.. [1] (no need of the time).
>>
>> [1]
>>     $ umount /btrfs;
>>     $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>> /dev/vg/scratch0 /btrfs"
>>
>> Thanks, Anand
>>
>>
> 
> Hi,
> 
> I also have a btrfs filesystem that takes a while to mount.
> So I'm interested if this could be improved.
> 
> $ ./ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/md127 -o
> space_cache=v2,compress=zstd,acl,subvol=Data /mnt/Data/"

  It is better if we don't use the time prefix for the mount command
  here. The ftrace, traces time syscall as well, which is unessential.
  And we lose a lot of trace-buffer to it.

> kernel.ftrace_enabled = 1
> 
> real    1m33,638s
> user    0m0,000s
> sys     0m1,130s
> 
> Here's the trace output https://dāvis.lv/files/ftracegraph.out.gz
> 
> The filesystem is on top of RAID6 mdadm array which is from 9x 3TB HDDs.

  So here is a case of a non-zoned device.

  Again it is btrfs_read_block_groups() which is taking ~98% of the time.

    3) $ 91607669 us |    } /* btrfs_read_block_groups [btrfs] */
    3) # 9399.566 us |    btrfs_check_rw_degradable [btrfs]();
    3)   0.922 us    |    btrfs_apply_pending_changes [btrfs]();
    3) ! 186.540 us  |    btrfs_read_qgroup_config [btrfs]();
    3) * 26109.92 us |    btrfs_get_root_ref [btrfs]();
    3) + 23.965 us   |    btrfs_start_pre_rw_mount [btrfs]();
    3)   1.192 us    |    btrfs_discard_resume [btrfs]();
    3) $ 93501136 us |  } /* open_ctree [btrfs] */

  Could we pls get this?

  $ ./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount ..."

  Hopefully, there won't be a trace-buffer rollover here, as we saw in
  the other case so that we could account for all the time spent.

  Also, let's understand how many block groups are there.

  $ btrfs in dump-tree <dev> | grep BLOCK_GROUP_ITEM | wc -l


Thx, Anand

> Best regards,
> Dāvis
> 

