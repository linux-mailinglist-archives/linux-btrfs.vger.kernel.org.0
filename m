Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82548403B62
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 16:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhIHOVU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 10:21:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhIHOVQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 10:21:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188DSFw6006035;
        Wed, 8 Sep 2021 14:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ek2CFdUD8X2/LLHMxqVaTD+Jjd/p/o1ICWFtTqJ7jbo=;
 b=BU6teeE6kQsI92L8cEop85vsKUeWYAktUMJ5u+DCwWlCG7Y+fYppSyXkavAd+IihFyPO
 4tcccwI6nP1YIbS9Kkhj3IPPbtZAH8H/PLmuVHMefI+y3d0qjwt/XFqnQOGFjTUcNVAs
 3bav4VZBE4YGoFYDbh6aMAY2ffnGE72K3zj6iDUEEK2IMpchyYQRk/TaK/mdREAatKc3
 KyE/S8aABXr0AQfUA2ojmLW0Al7WjizWQg/UC4EOhLWf1KJb2GopR0JGEVtH/0q1/sh3
 elrL90HkkX5Y0jrLbyPXbPt9g+o+XUMNOFfObPGyoxl1YQ55+F8NiyhID5e5xIHv6vwC YA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ek2CFdUD8X2/LLHMxqVaTD+Jjd/p/o1ICWFtTqJ7jbo=;
 b=ikbGfx+aIJuKaeM/Ai1hI9QaRYgPbLl1xVvzo++Sv3iBnzZAMP6W8hoKwYMJd87muZSV
 V6Y458e1giCbH3ySvxrKRSW8Jk0lJHRrgroqb71pEcPMTbUfi113j7+VqrBgvoZRi0SD
 52AVabjvckGLlNMRzBHJme6OcWcFT9vJyOT6dVROuvsm2Hg9P65I4GmknVYxnF/apfFh
 UGVfXMfN1IlCCWIcBGk41dkiXH+xDhqOSwgIGKiHrQOsSV2jzMqLQslPGAa79smhBtSI
 AuoP+nVf/G/HTR+23mPaQpMhyD1ea3Oo52CzNMQKsdgrpJ0h26DDuwBX1ZDl8c/1eXL9 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q2w6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 14:20:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188EK6Zc109256;
        Wed, 8 Sep 2021 14:20:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3axcpma9jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 14:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWMV492/+jdByE7bZiID1l27ldplyJMhK+4GWYZp0aCDwtNQI7/VqJfYa3d6gj1+Xocm9HYe5d+I6fw+90XkYJVyayL3VK7ztTCB1PkjRNcxsfZBQu5CeesmYg/HZArADEMD2NDJkYE/5Peu5cF337ROKnQX8bFkvjK3N2bQHsbCVJKrdSSsLf+ht6SbgNiiHIl6cQYFhau23OMxljSKNSCUDnC/bl83S8h/Njk7+CHgCXPN0pKpsMLxjsTLzE2eV4wMa08ULPlxqGHmNi9+xq+1KVLFMzmOLbRkI1k6nnI40zkfAId9YoQINJcHkdrnnyvlTy8rnSchFsJRrlW9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ek2CFdUD8X2/LLHMxqVaTD+Jjd/p/o1ICWFtTqJ7jbo=;
 b=kkWW71RMWj+W/2uD2PuPQiWXg3CbQus7covA6AgcY1+rIHyrcwLHhxJJL5eapWlqfMnDTQEVPrJjjuhaT5CKOaVhU10uypmGnsiN6gLXRKACOc9DEsLvcVl0G4Ys4VxLZEEy+zz/Fm0Jjn1JilcxcEkT6JjmEpFK4ry4neTOY0m01qmRfEvFuQZY5o8OJy9PZHqo/Jkzn4plTwOXbHTeuf7IO+VE/mEcO507YVSBrVDH4RZJW2JTt40h2JE6EgOKZSnASsbsjJWb1vZmunYrsln3QplKjLWz/z72eeTuBlcULf7Mcjlv242rPjya2nRpjnyVx5j01A2T6CJeBeNzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek2CFdUD8X2/LLHMxqVaTD+Jjd/p/o1ICWFtTqJ7jbo=;
 b=Ae1Z8PFFbfj2LLkRBrLdUbW5gHvAedtMCCS7wh4vZ3bxkQxSPDr1ql9mSTmmLC+zkCHK5y7zUgKparmiAE4hweztDZp8pSXVQ/Ca+x/+Q8V2tLouF1uW8k2amQH0xWK6f02SQyJh2KubRfv8cuVa6T9bepL9G26LlL2EGbDaTBE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3774.namprd10.prod.outlook.com (2603:10b6:208:1bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 14:19:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 14:19:56 +0000
Subject: Re: [PATCH 1/2] btrfs: fix mount failure due to past and transient
 device flush error
To:     fdmanana@kernel.org
References: <cover.1631026981.git.fdmanana@suse.com>
 <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <89c736d1-2e8c-b9ef-40a0-298b94fcebde@oracle.com>
Date:   Wed, 8 Sep 2021 22:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0165.apcprd03.prod.outlook.com
 (2603:1096:4:c9::20) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0165.apcprd03.prod.outlook.com (2603:1096:4:c9::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 14:19:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b69dba1-1321-42bf-b57c-08d972d3bb80
X-MS-TrafficTypeDiagnostic: MN2PR10MB3774:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3774E3C45FD6772AB837F7D9E5D49@MN2PR10MB3774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bdnge7lUGyc4h0Wwe+1VzsHUYpiAVE7FGKsZ4Nuzo8gdWwJr5WC2/eQcJRMZCz9z43HaQvN364mY18abfakenL0hPidwl+tsgBSrwrt7mbnGacaEme5mz2f/Sz9GM3t+g9kL+TZ0TwXP0qJPkSqcpHrrvk77LPU4NgskIHJDWouCIX2zlqsmIhrFIWmfbeupi1ZSpuOx8kBcaEt7+v61f9WNOS2odjorupRwP/3YFz4BAwX5byPM4PBOoy2nUfKHCiuJBivQiw/1cLvdlhRA/5G+JzIZksmENQ9XHaAc1tFVZN44bBpBscuPyMwWtmnKcSzXB8o5S+JxwRPOBTbXR+dfkjUQ5yQxqi7ZfwJx5Wd/BMPxZDQL8nXN3/IevRPAT3YtLnI1fisT048c1mCAAOkTvFZyrK8q0NW/C6UaYsgrGzG61623Eu7srwhn/4J4RXSELyBG9UZMt0vIah39TohSJuqQHLUoiRUEUYpbWfINGS0DgD1oIc5+NxvzGUMLCyAvaJwANHCo3Mcbtd5RfR6xYCG/dUsuu+66FzaQy0xh6AOmK+kdsFMGpHwEzX6UO7wO9s4M1HziSb+TjZ25teO7rzFcJVkJRxqVjjXpb5045AnQVAaw06gsAuPE/R4focm+NAk52aSRh02VysUEGBeb+IWzqCanwx7AvtD8p9zy9p/A/pKZQp/Lm60mR/CgJ26og5y8R4UEJtHNiQf7eHRGgeAtjcQ7b6qJ4WWiB7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(316002)(36756003)(16576012)(6916009)(4326008)(478600001)(2906002)(6486002)(31686004)(8936002)(8676002)(31696002)(38100700002)(66946007)(83380400001)(86362001)(66476007)(186003)(26005)(2616005)(956004)(44832011)(66556008)(6666004)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Z5V1lBM2o3a1I2dkh3dThRakJkUk9yMll4SjRYU0c0aUU1ZTJXQUNHM0R1?=
 =?utf-8?B?WDg1b0llcEl2REljQmxEdU9CbCs2REVIWlUvTXpOY1ZTdHdhTW80WlJONUpa?=
 =?utf-8?B?ZFZ0VDRQMGhTcHpuZFdjSkJaVEpXUmhYcW9WREVIek1jMzFDeS81QytOOEdN?=
 =?utf-8?B?QytHYTdSNUNhTERKQnJybTQvMGhNKyt5Nkt2Y21ObDRDNXhyTWhTMUJXZElk?=
 =?utf-8?B?cUtsSDhKL3ZCaHVoRnpnK0cyOHBoczRLSkZVN09VOGtTMHlzZEh3azc1TTZK?=
 =?utf-8?B?aFZGUHVndVgyUk1ZclVDUWJTSHRlRW4wWldGT1NsN0RoeVhibFJ3bThiMzJG?=
 =?utf-8?B?dkpiTzVmQjdUckErL3p5T3cydGNGbFhzbmxZdzl4dFdMUzQ0aXJRVlVUUGNO?=
 =?utf-8?B?TmFQLzZHa1psMnFFak1VOFM1ZjVFNnBZQnVCRmZpTjcrK0xrbWN1b0YzOVQ4?=
 =?utf-8?B?cGdXYm91Y2p6MzhPb2I1bFJLSEpyRUVmT0dWNXFoMXB2R3gwZXhlKzRNZk05?=
 =?utf-8?B?WTZSeTMrU2dseHF5dWV1NzRpWUZUOG51Y205Z0hKVVdtcVZiZzlZZ20wTDRK?=
 =?utf-8?B?Vkx4QlVHOFc4VGpUd0FRb1lCUDZhSm5OcmRScmhkVlU3S1ZuNUJIdVY1ZUYx?=
 =?utf-8?B?VTM5em5DbjFXS0YyQkdRYVNiQ1psRmpnMHEwQkdRVTI3cUV1cFZmbUsvcW9i?=
 =?utf-8?B?bkU4QUxpRWxabGhveFRqY2JtS2FCaDFKcW9GeHRGOTg5K3FCbmNRNU9RRHlF?=
 =?utf-8?B?dWxzOGZndXhCdmtiTTQ3LzA5UVZSRkFaNGlUMXQ1ckpCeVZvQ2xNNWRiQ3o3?=
 =?utf-8?B?K3FJVVJxdlJCSTZEOTh6VE9IZ1I2Z0MwNWxOK1FBZjQrb3hrb1ZUQVh2Zm5t?=
 =?utf-8?B?Wkd2SFNQYUh1WWZsREU1TXNLVVlCaC8zZXFuMnZJTWxKNkoyMWMwSTJQU2tl?=
 =?utf-8?B?YUxpSGQ4bDhnYjErRHorWlFkWlc5UThrOThHUWlvdElSWWcwMU8rODd1SDl0?=
 =?utf-8?B?M3BSeHVTTDgyZVNaTlhKN3V6VnBFTlprcUtjKzhwR2U2Qk5iQUxYT1pLYTRO?=
 =?utf-8?B?L0lRd21GanZaYWlvOTI2OEk5dW53YVIySXFJaVlJM1Rsb3lldkRiTzZ5a2Fp?=
 =?utf-8?B?dmxpZmQ5eXZscEN0THdBeVAyRU5FaDB2cGVQK3lzVlpScVVlN2RLcDFzUm1D?=
 =?utf-8?B?Z1ZNaHpMb205ZlNxL3g5TWJPbWJBaVd6cXc4UWlGNHVKVUZoWjRsMklhTkc3?=
 =?utf-8?B?emtpL3VnK0hHLzF1YThMQ1pGVnZUNmNna3JwMGh6bnpVb1hhQjJ2OGRKb0p3?=
 =?utf-8?B?OEh5SXlPVVpocDdjZStpMlU1UjE2QndmRGw3SFIzUXNlQXFNZ3FTaXhNMTJo?=
 =?utf-8?B?WSswOHBpTy9kVDZuTXN6RllJVmtBaHNRdUFRMmVBbVRHMWVML04wL1gvZXJm?=
 =?utf-8?B?VGpET00yYnA5bm9tY1NUcGNNYTdQNkhtbUpqY3ZaL3dEd3ZtTFBwSlFSTUNK?=
 =?utf-8?B?Z21UM2QydFVreDhSMWdkV3p6NUpoSi9WRS9ObWJHTlNtUU5yQjNFemVmb3N2?=
 =?utf-8?B?QnhJZUNUZG9QdFpFZ3E2SkxoclB1a2N0bmE1UmdOUnhQaGpUVnI4ckpteEw5?=
 =?utf-8?B?VzVpUEFZd2JxT0MrcW56UHppYWlyRTFaamJ2Vlo4NzNGSk9leUFnNnh6bjdE?=
 =?utf-8?B?NXRFQ3c3RTluYVlTT3hvYmdpMi84YVRQMDBRVE5ka0huU2J6alRzRkVEeFRh?=
 =?utf-8?Q?HKx5TRjxqaGjUSAWzYKhc28pijgj2YYmgxtUYaE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b69dba1-1321-42bf-b57c-08d972d3bb80
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:19:56.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2Wzrn8Tsor0uDi4XtwsODZxFjODZZPo4rCzeH+Hr+d5+q8vUpv06ga7F5POJm1kin/AwvWM6X19wS1sC85RGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080092
X-Proofpoint-GUID: wbh3xvr4fxKbk2JA4MJRYnLVIuQzXLY6
X-Proofpoint-ORIG-GUID: wbh3xvr4fxKbk2JA4MJRYnLVIuQzXLY6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/09/2021 23:15, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we get an error flushing one device, during a super block commit, we
> record the error in the device structure, in the field 'last_flush_error'.
> This is used to later check if we should error out the super block commit,
> depending on whether the number of flush errors is greater than or equals
> to the maximum tolerated device failures for a raid profile.


> However if we get a transient device flush error, unmount the filesystem
> and later try to mount it, we can fail the mount because we treat that
> past error as critical and consider the device is missing.

> Even if it's
> very likely that the error will happen again, as it's probably due to a
> hardware related problem, there may be cases where the error might not
> happen again. 

  But is there an impact due to flush error, like storage cache lost few 
block? If so, then the current design is correct. No?

Thanks, Anand

> One example is during testing, and a test case like the
> new generic/648 from fstests always triggers this. The test cases
> generic/019 and generic/475 also trigger this scenario, but very
> sporadically.
> 
> When this happens we get an error like this:
> 
>    $ mount /dev/sdc /mnt
>    mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
> 
>    $ dmesg
>    (...)
>    [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
>    [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
>    [12918.890853] BTRFS error (device sdc): open_ctree failed
> 
> So fix this by making sure btrfs_check_rw_degradable() does not consider
> flush errors from past mounts when it's being called either on a mount
> context or on a RO to RW remount context, and clears the flush errors
> from the devices. Any path that triggers a super block commit during
> mount/remount must still check for any flush errors and lead to a
> mount/remount failure if any are found - all these paths (replaying log
> trees, convert space cache v1 to v2, etc) all happen after the first
> call to btrfs_check_rw_degradable(), which is the only call that should
> ignore and reset past flush errors from the devices.
> 

What if the flush error is real that the storage cache dropped few 
blocks and, did not make it to the permanent storage.

Thanks, Anand


> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/disk-io.c |  4 ++--
>   fs/btrfs/super.c   |  2 +-
>   fs/btrfs/volumes.c | 26 +++++++++++++++++++++-----
>   fs/btrfs/volumes.h |  3 ++-
>   4 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7d80e5b22d32..6d7d6288f80a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3564,7 +3564,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		goto fail_sysfs;
>   	}
>   
> -	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
> +	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL, true)) {
>   		btrfs_warn(fs_info,
>   		"writable mount is not allowed due to too many missing devices");
>   		goto fail_sysfs;
> @@ -4013,7 +4013,7 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
>   
>   static int check_barrier_error(struct btrfs_fs_info *fs_info)
>   {
> -	if (!btrfs_check_rw_degradable(fs_info, NULL))
> +	if (!btrfs_check_rw_degradable(fs_info, NULL, false))
>   		return -EIO;
>   	return 0;
>   }
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a927009f02a2..51519141b12f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2017,7 +2017,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   			goto restore;
>   		}
>   
> -		if (!btrfs_check_rw_degradable(fs_info, NULL)) {
> +		if (!btrfs_check_rw_degradable(fs_info, NULL, true)) {
>   			btrfs_warn(fs_info,
>   		"too many missing devices, writable remount is not allowed");
>   			ret = -EACCES;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b81f25eed298..2a5beba98273 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7367,7 +7367,7 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>    * Return false if any chunk doesn't meet the minimal RW mount requirements.
>    */
>   bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> -					struct btrfs_device *failing_dev)
> +			       struct btrfs_device *failing_dev, bool mounting_fs)
>   {
>   	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
>   	struct extent_map *em;
> @@ -7395,12 +7395,28 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>   		for (i = 0; i < map->num_stripes; i++) {
>   			struct btrfs_device *dev = map->stripes[i].dev;
>   
> -			if (!dev || !dev->bdev ||
> -			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> -			    dev->last_flush_error)
> +			if (dev && dev->last_flush_error) {
> +				/*
> +				 * If we had a flush error from a previous mount,
> +				 * don't treat it as an error and clear the error
> +				 * status. Such an error may be transient, and
> +				 * just because it happened in a previous mount,
> +				 * it does not mean it will happen again if we
> +				 * mount the fs again. If it turns out the error
> +				 * happens again after mounting, then we will
> +				 * deal with it, abort the running transaction
> +				 * and set the fs state to BTRFS_FS_STATE_ERROR.
> +				 */
> +				if (mounting_fs)
> +					dev->last_flush_error = 0;
> +				else
> +					missing++;
> +			} else if (!dev || !dev->bdev ||
> +			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
>   				missing++;
> -			else if (failing_dev && failing_dev == dev)
> +			} else if (failing_dev && failing_dev == dev) {
>   				missing++;
> +			}
>   		}
>   		if (missing > max_tolerated) {
>   			if (!failing_dev)
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 7e8f205978d9..7299aa36f41f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -575,7 +575,8 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
>   
>   struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
>   bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> -					struct btrfs_device *failing_dev);
> +			       struct btrfs_device *failing_dev,
> +			       bool mounting_fs);
>   void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   			       struct block_device *bdev,
>   			       const char *device_path);
> 

