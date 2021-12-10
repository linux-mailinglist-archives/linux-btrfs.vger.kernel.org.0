Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F88470105
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 13:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbhLJM57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 07:57:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26528 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241067AbhLJM57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 07:57:59 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BABHwIV016425;
        Fri, 10 Dec 2021 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bgHUspzgIF6pEE7Nv7dta3jac29wLHezkE6sgI9R02U=;
 b=a3rWTyjiCoO2GFQOfSpDRMGCcs1nkLSCEZub6Tp2+izJk+Q+TWNWhwvkl3Mr9cLMWNTy
 u5/nao13uYI9jun51FuTcxoNj1YlvVh248X2sWma7VLj1IHCXUZ3dsN9iUeIBBW7eues
 ULxzGX/EW36NYmyebGWKTiA6QdEKtGB04/IFhXvJOkJSsEtLH2Hz6QYsAuz/PDncUavt
 EiZUIyTEoy8UiCTL51U9cDK2J0hyi/h8ul9kPHdYZd2smcyLNzqjakLV/s3GqhC2Yw3X
 GhvhSIlvgWP4ZZ6mZkyp35rh03adNh4ikLaOxqYjZWpIQy6W/m1kOgJ1Sja5Y6hQc3py 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mwv9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:54:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BACor8L091181;
        Fri, 10 Dec 2021 12:54:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3cr1su6ju2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBhRcSYT3tNsvOvwyvhpMwgsiV7INtKqr+5i+JYzsz1W0lG6eTryfDzQfph9lqqGZL+ALcaf9Q+qFPTddrpsBlaiO6+nGpdqKHNEAcoQHgrhDOUVbVYpu3dEN5LnkXrHug2anKZpNGx1zsx+1ek6eUDWh3rRRNf3zdtAeIn8QVM064SFW82krGV00JgMUytvJVC02FUXzZTh4pmAM5fXbFWOmZzeTTJBfIISREQmiKPkXkUHISdF3E8NRJVFtX/jEwDUauFkihXRcsKfCAxr3SPqYdgrBBLo06B0khQIUyIhfMd9r/GpX6NjceKUnwhBRwoiqzVDWCccn4dpN/q4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgHUspzgIF6pEE7Nv7dta3jac29wLHezkE6sgI9R02U=;
 b=TiD5c2yn8ykbl+mk8hOwFK6q8V8S9RG3EnBvLIGtyBvY5plUY1Iokxjd9+/i1j+TD7iUgniA9O27WDZ+QnoVEGwjWozMEzP/GBem8tWL871ryOMkT0DbT4TiMxWjZxsEdeRjZy41Wo3Rm/+wk/PZbC4MViPltjX4hVayTfewpwP0MLWcZW3QlsEtqTLU+VmPWNihKCfb6EYXe2dLFDueczTntYefP/Bni+AvXLT+RBawQ1h1a2dmcaN7DS0D1VrqSUDN7KRojT/z70O6o8taQmA3RYUaw5FLpSiv1MZzlfqy8+95vjqCWB0aMFqiPzgvb7SW95AMfqdMrvnSMF4eLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgHUspzgIF6pEE7Nv7dta3jac29wLHezkE6sgI9R02U=;
 b=AOfKZoPVjvvY/idwKiAgyQzGZBxDTBGGCupqy+WQ6s6c8AAdGk+La6EB+hLrvyd0mMN8w1db33V1H1d3GhzYlF1LlJP2Ro49YKP8bhQzbwfBQ2GllzzMADPxTSFbjydJz5iKWyn7pz2dqym97LOQ4PdLaVwMmX94ESPhrdOJhV4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 10 Dec
 2021 12:54:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 12:54:19 +0000
Message-ID: <8195040c-d8db-43c2-2f7c-4a57755721ba@oracle.com>
Date:   Fri, 10 Dec 2021 20:54:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs: harden identification of the stale device
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
 <YbDBVeyJ8YhOw+Bt@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YbDBVeyJ8YhOw+Bt@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0125.apcprd02.prod.outlook.com (2603:1096:4:188::13) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 12:54:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913da31b-ddee-46b4-d497-08d9bbdc2e5b
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB49800958BB042A2D572F74F3E5719@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYRn4Njd53/LrBdalf/KbqteEEf6tdM0COQLe3AeKKCO6bupnkxrh46PtLKucCNoUhQDTe3PR0smZGwsSuoDS8EYsDv7iK8VvFtsN5DYJjDFqc6sfIlbGBvHFePxKYfF7X/ZlSW63rBUEfSKROIK6TK64malM/m/rvcRO/ctYsYYSr/82kysivVpwBwoUhPmKjDTM3DbrM8i1/6kjYglJ+4zLxSdy5mCvBN+poex0IPkcizMDr3s0OcZGXGYGcYklpqjN2eDe98DY6bRyD/nzoX1f0h5fRNu6tGQq+VBpX4DHN1ieF+nkZvB2ew4iq0YcbRKGKvBPTVXe0dRQtsVxXkI/fF/LEPVda5t9tc8y2mlXjTHaR5aByG8y6W4V45hKG2/mG8AMFNsRrdk209CiqYexCz5zzgO562GX8owrhxYCGwF4IJznEUAV8YHVuRqL1K7llNs1SZU+EhcxsQO10dVF6kI1+81DrFBzbMlfQZsThrjFV2cPbHoNWlhncpACOIZlTnF26zPG8wcX2KOc1E4Lfg5eBt4M1J/5p4EnHJUKr2eVvPeHofpfh7XnKqaGuYScLoQ/DNSQzZEtZBGhxXs5aqpRdqhB42J48HkaqphZsRSuJmvyKC5Hze7EideqTgKQZTjXhuRh6pOQ1CcRxK6V/p6I2lWzCiA672nIXHHGGSZ4cTMSwasPTMS4/mTXVsOwtyajABFt649SNJzVBRVcNoMXuCt3FMBqwPGFyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(5660300002)(956004)(2906002)(86362001)(66946007)(66556008)(66476007)(508600001)(6666004)(186003)(36756003)(4326008)(38100700002)(83380400001)(31696002)(8676002)(44832011)(316002)(16576012)(2616005)(6486002)(26005)(31686004)(8936002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGpRQjZiVWhoUjVXd1dQVWo0ZCtoV2REN3I4TTh3S05obUM5RS9JQkI3bzln?=
 =?utf-8?B?QkllSllaQ0VrdE5JM21hUUJpZ2dOSThML3NKS3RNbTNtaEJDU25udyswSjRE?=
 =?utf-8?B?VHZPVHkvckRNNGhnVitQdkc5RGlpQzlDQ2N4VmIzaUprSGVvS3RnM3N2Mi9C?=
 =?utf-8?B?eFJKRnd5cWlZcVJ0dUVUVXJ4WG1PcEFHWE52RndLeVZEYzk4TFliV0hMTXVy?=
 =?utf-8?B?R2dRMkRsVFgxN1BSaG9yK0xsZFAvZHlBaCtPbUJmQnlSM1g3RFZSaVpDTzdn?=
 =?utf-8?B?dVNmbEcwUDBKOFNJL3FSTkZZc3MzQUYrVExBUjcyQnFSNjVjcVYzd1R5VUJC?=
 =?utf-8?B?WXJhS092QVJqVWZ3dnFmRExGR25QTElvT1VEcW5BUXlmQ0dQRUlyWDRkdzNa?=
 =?utf-8?B?UWlGMm0rTjZBK2QvY0VKVjVCbkpWY09RYTgySzFJUEtEMHJFV2hnbllWc3RS?=
 =?utf-8?B?NkcwUVZ1a0RSS093dUlKRWNFNk10dGdUYjBFNHNUNjM0MTVtcUxWSzk2TVll?=
 =?utf-8?B?c1ZJdXJIY2tLUHRUa0FSamJwTkFsTk5vK05pYTg5c25JTTQzNmoyaVpTUW9X?=
 =?utf-8?B?cEtoOW9oeUpWT0t3Tlg1NDZUNmMwTjRoVDBPdTBYRWxEeXVYZ2MwVjFuNXV0?=
 =?utf-8?B?U1ZMT3Joem94a21FbTJtSm5xcDQwTVhWb2hWWnBRY2NxUmtyWk9ld25wNTFi?=
 =?utf-8?B?cnpDeTM3WVYrL2RXeVZuRDdxMjRLODEyMm94WG8xL3BOaEpZeU45V3JESGR3?=
 =?utf-8?B?eGF2c0ZJelpYbkpkZENIODNoRGpodzZxckkxTkVIMG81MEhIV1BkU0Vkc2tZ?=
 =?utf-8?B?Y0p1RFNLbkhCaHIvWXFUUDR1SG82R2tvKytlem1uQ2ZkckJQWkZkUXdodXpl?=
 =?utf-8?B?bU5OZHRkTDlDRVF2aU9udzVXRFRaUWVxUkRUWFVMN1hUSU9mMldmbFNmbzBa?=
 =?utf-8?B?U3hSanpNR0ZRM1JZS0FTSzB5b05OTUJZTTVPUFZSS1JvVDA5ZVFzUlJBRldn?=
 =?utf-8?B?TFRZKzh4WklzSUlwNGNjK1lST2YwOVFTNWVlWEJMTkJnUHEzYTM0Zzc5THAw?=
 =?utf-8?B?bnEzYjJ5Uk8wUm8zU2l0cWZ5a3BZL3NqUXdaam16SEptQlBiVVFXa3l2RGlP?=
 =?utf-8?B?QlZNVkd2ZXh1NGtDcnZKZ0dBbWtEQWYyTyszdVFGczJIYmJQcjdMNzhQRG96?=
 =?utf-8?B?RWhNZFlEa0F3d1JyWnBYVnlwS1Q2QjhVekE3b3BWazN0SURLcDhTYnZMQk9K?=
 =?utf-8?B?cG9GMnlIV3JSRkJGSU82dWcxek5COEFnNzY4WFlPQlRtb2FPUWk1Nk0vL1pF?=
 =?utf-8?B?TjIrTnAwNzRJdVZsNkpSeUNhV3o1Vkw2Yit1RXAwUHNMaHhwWUJFR2pURnRV?=
 =?utf-8?B?bXZMYkFEbzJvbFNzWS92MHkwaU1Tc0VvcFNyenFaTHdMbXpoZG1pSkVkY2Fh?=
 =?utf-8?B?QnhnVFM4WDZkdWM3alZXWmNueUQ1UjI5RHA0SXVSMm9PVjVaeUNmdzBMVGN1?=
 =?utf-8?B?T0xGbUFKenJDSXlRN1NmMitQNi9Ha3NrUlI4TEg4bTd5U0J4SnZEOGdMUlJD?=
 =?utf-8?B?Tk9FZGx1aUxHNjlTb01mQVN0Z3N1aExkQlhOb2NVMWxKWUdkeFZ4dEtON2Er?=
 =?utf-8?B?RCthejRvdURkSEJxQzlNcTQzTFMzc0h1ditOQ3dYV094S2J6QmxDcjI1RWtt?=
 =?utf-8?B?ZUNyNDBBY1VXbXdXU25JVFhuV3BMdWNaZzNuQVdGSFRCMVk3eTdpK0lwZGZp?=
 =?utf-8?B?dXFiUFhmQUFWN1hxRFpNbXg3a3hTOGlDalZiNzR6Nm1FUk9FakRET1plZHk3?=
 =?utf-8?B?QjlOVC9HUjV6bTJST01HYW1XYlBKN3pMY3BycncydXN0Qk1xQ3NSWWEwMWdw?=
 =?utf-8?B?NG8weFFLOThRcmt4MXpQam8rdHlHRDFUVGpwVmVrdHZFdDF0RnAzWXIvYWlq?=
 =?utf-8?B?ai8wbzRvL1QwT2JzVzVQb0FNWnA5N0t4cTZiaDdqTnlXdFc1bEl3ODhwdUpx?=
 =?utf-8?B?V0YvbW44T1RSd0ZOdUdubWlSSmZoNTBzazhxZEttbHQzaXJYRGw5WU1qdkJE?=
 =?utf-8?B?UjQ1TzJ4UXU0NUJvRnVyNE9HVkFEWlFzUU5YOG5ENjh5WkFxTFJ0SU5oZ05E?=
 =?utf-8?B?ZWt2RE1uZnVpT2c1dmlncFhKeVBVa1RjY1NXVDRHaWZJT3M1VGFEQVk4QjlX?=
 =?utf-8?Q?oZOd8XeAjIWlSCSThisvCk4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913da31b-ddee-46b4-d497-08d9bbdc2e5b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:54:19.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl+nCs/DPm4bl3vvWFSbNtr1pPqJN190Ep0Aarq36waKc73p1E8VhsgTO2FCKlj5dMsmlpmiEFrpWLx1+JF4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100072
X-Proofpoint-GUID: 5DN6l13CMZbHz7S4tb_3FsBIuOYBaeP6
X-Proofpoint-ORIG-GUID: 5DN6l13CMZbHz7S4tb_3FsBIuOYBaeP6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/12/2021 22:29, Josef Bacik wrote:
> On Wed, Dec 08, 2021 at 10:05:29PM +0800, Anand Jain wrote:
>> Identifying and removing the stale device from the fs_uuids list is done
>> by the function btrfs_free_stale_devices().
>> btrfs_free_stale_devices() in turn depends on the function
>> device_path_matched() to check if the device repeats in more than one
>> btrfs_device structure.
>>
>> The matching of the device happens by its path, the device path. However,
>> when dm mapper is in use, the dm device paths are nothing but a link to
>> the actual block device, which leads to the device_path_matched() failing
>> to match.
>>
>> Fix this by matching the dev_t as provided by lookup_bdev() instead of
>> plain strcmp() the device paths.
>>
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> We already have the bdev for the device in most of the callers here, the only
> exception is btrfs_forget_devices.  Can we change this up to pass in the dev_t
> of the device we're trying to remove, that way we don't have to do the lookup
> over and over for the path of the device we're trying to forget?  Thanks,

Right. I have made the related changes and, in v2, this change is on top 
of this patch.

Thanks, Anand


> 
> Josef

