Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0737802B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356328AbjHRAWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356729AbjHRAVd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 20:21:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB5FE
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 17:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCYE9HciBzcUFGZ+c9J6jS+J9QLj240ugIFi0ZDyyX/5Yv1h7roipcTvhNtVCXJrVcHzMs9/wQuwRUBLMqoTMXIg8I7+AtdEXhsNrF2BmoYXkoCa6hQGzarsLczXEuXxq79Nbzy3UX1oGYDwAq98dUCKeKSODlI1GZ/sdvGNXdt47GzcyB8e/mGo6OI4/yZ2kKeXIQ8MNNRY1RVp+5Fmw6r4lOvHHVCYCf/6u5859WgK7JX2lPz8ICwqySvU8EA/nsJFFx9eeBn27T8nx4hN2gNDwcnNkpgsFWcwm8Hj7P2+P8r8jvOS+iduIicGD1vTdbtV+yCnWiosANIlboOIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=520xnTOkYRQrWt43TWY9a2rnuInzI5mFiaZ0hYn/jBo=;
 b=bUiYE23IE+B1XA3yw+F6k1AuuZWwKPBeRVF98WAg7kT6fuoCGwW53f4v2qDRn4iop2+ZTDDgndlonWcgRnOfXLJ9CLQbHHrEAVPQ+2yRvD7/Qb1qzOw860Q7vugxr7mHLC06T56dDnyxUhirUb8iwPhgNVK7eF6D50j4TEFr5ufLpTZnJMKV3YwKH5ffolli1yu+BA/ZmIVWD5gkz0JLd7AyIYoMEKr3fBXEbWk6Y3VlSRw3aFQvEPz24UyZS8dI7iZKLehr5iNUGUb+Cg1xisVPitxwg6jh99U9JJtKQ6SJvCijWlbg2zcr9Voe8etIWVVnGUjPjHtyloQjFQejzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=520xnTOkYRQrWt43TWY9a2rnuInzI5mFiaZ0hYn/jBo=;
 b=eEm6cED2eK1nljReLCs3QloC/qKgDprgqDdb2PIYNyxVLxbHnuUkoDO4EQLVXUTUnca5qynol7bS87RdXjfxdOsKteptFPOPtGlqW6+DHuM5mnVyvGvTjahkOrHQsB0QgM2z7hG8nYXqjsgTF/M7YfjjrRggV/0D24/9ieu5ZN0ifZnzW1zg/Kttu2QUux0gCYJjkrcpEF10jcfPClo91cu/DwSkccKQ6SZmjfHOHRogQzC0Y9h66lzNl8f2GhZEEV6B+F0dt7I8FgRjnJCzNUYJm3ZfaYo9/bGJddo7vcd8CXrGlbHYPZtqndQQbInH21NFUHIRVD0fuPvr2ah3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.32; Fri, 18 Aug
 2023 00:21:27 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 00:21:27 +0000
Message-ID: <5fafa142-7995-4603-a6b2-8360dda8e7fb@suse.com>
Date:   Fri, 18 Aug 2023 08:21:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject device with CHANGING_FSID_V2
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com>
 <20230817120424.GK2420@twin.jikos.cz>
 <25703f72-c647-d8f7-a150-fb7c66842fc0@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <25703f72-c647-d8f7-a150-fb7c66842fc0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: fd281d7e-67aa-46da-44ca-08db9f810fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVjUIHefbmztbYrFrk4WTIALPb5s/o/yoNC9X6aEDWV0NH9VO0wsP6nVJ6QVY8kQQpPOHxFh/40o2cXwrzAqsM+KDXYl1CN5yUk7v2IlVuOoXle5crdEgHxvxwF5oJoo6GBX+3drUHonGJvPTTTTIA30XyDmiaTlOLE5DVAKiBl3WQnegbTpqc2kxW8QN2oGBV5LUUpZ9fijd2I5q3hQYZlwz60gpJ79D0SuoSbatYgj28NG6p1Scu+4iZC7039wypbao3Yyqd/SvfZkYIz3adUGmMyaVCqKbfkD/2xiGTH6Fhh3AvFMaNsiLOSED1VjOWc8N4NnOunPfOPcVJUF+gCa4yKxhaJ1kfsdNv32n8Af/YatJbrTy8Kr9RLe0VmYjITGqb+JIbGML/B75hBk0Ty5nAsBpuq5cSvZ/26+cboR4ud4wPpPx3KpxT+LODQV8HC0Y7e7+7kLWPMLWuJoCryrx5Acfwo/zetWUcmM/7hPPB+dPRMiML7pUDWR1r4kJ/v2eUgRrhjLClDDS5xP0NEAzvTJh3XqQX/CjcoliByNm0TVIXuazsTpqXpLKxWIIHhIQCcB4nN4xq2EIyKwVImnG5DfQlQLzIX772WSuf/LLDR8KCkQNlg0ZndtyVlzpBFhmGs7deKPsG+OM1E5dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(186009)(451199024)(1800799009)(6512007)(6486002)(6506007)(41300700001)(66899024)(53546011)(36756003)(2906002)(86362001)(83380400001)(5660300002)(2616005)(31696002)(38100700002)(8676002)(8936002)(4326008)(6666004)(478600001)(66556008)(66946007)(316002)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alpjdmtyWi9BZGI3cGRjSERkMVdHeFZaRXRYRjBZNlZ0YjVlWXg2eXFWNThP?=
 =?utf-8?B?dVpVaW9PR0NjcGxqV1VPb21JNEUzMEhjOTJRZTFObFViYW50aXg5T0R0emVT?=
 =?utf-8?B?aE4rUkxlR3FCRzFhZzM4S0dvNWhlRmVQVkdLKzc0RG8vdjVxSFRuVktFbmxB?=
 =?utf-8?B?enRIdDk0SmE1MHVEcDdyeHh3SnhXdVQzZFFRbjV0SzZwcjRUY21IR1Zwc1dQ?=
 =?utf-8?B?UWxkWCtETU9XZnNHdjlDL0lEZ1J4R2Z5d01DTTc4cDNhQVZWRFd3M0liRGtU?=
 =?utf-8?B?bUNIMy9jaE5ZaEs2YTluc1p0QTVUMEt3NnRHeE9zajJvU2RoSTdWc2ZYcTlk?=
 =?utf-8?B?cVdibldWU3I1T0ovWVdLQzBWNkNQL1dGclBLWDN4bG9aVmdobkx0Zm1CTTJH?=
 =?utf-8?B?UWhreTlTaEpsMDk4YWJYWisrc3pQT01valRKdFVweXcxU25MK1p1TnFQd2Uy?=
 =?utf-8?B?cGhyQjg5QUtBM3F0Tm5WMGc2VG56bHZDNWJreE5IWm5HaGRYdURYUGZzUmRG?=
 =?utf-8?B?TTlTaElscEhGUGtENFM1eTA2aTlOSzRyR1NMa3M4ZVVrZGhkeDJ5SjIwYmdi?=
 =?utf-8?B?akMrUVNGOTRhWGU4bCtFUjFoQUZ0MHN5QmV6ZkdiNzlPazYyRXB1OXEwMUZP?=
 =?utf-8?B?dmNyeXhlMVdDUzZXNE5ucEJHR05Nc3JvdlRwL0RBZlVhRlJ1SXJPVW5JdG1h?=
 =?utf-8?B?RWtVZDN6eFZiNUVIajRkNlRTV3FPZXd5UkZZZHpqbkkwU0FpVXE4VkJwcEdP?=
 =?utf-8?B?aGJhR3dqVXdRc1AyOWphZTdIaktqaXRjU3lKZEFzM3ZYSzEvaFlWc2lIa2RF?=
 =?utf-8?B?akdiY2lOcFd4V2hRMEtpUUx3VHpNYmlqY1l4WFk5TFd0cFBwNno1NzlqRmln?=
 =?utf-8?B?ZFVuS0Zkay90L2VpQ0M3bm5nbjl3R0dCVmNKNU9obkpOR0NVQ3ZyMHRMazF3?=
 =?utf-8?B?NS9TYUZUSUVxMlI4ZEZnNEZrRmwzd053TzZURUtCN2hkUFc2S1JHYmtkKyt0?=
 =?utf-8?B?ZFdmc3E5ZVREaFNGN2JvMWszMEIrcHJXSkNJT1B3N2ZKTVB1TkVqTkJEZnAr?=
 =?utf-8?B?Rk9YZVR3akRqM3VpZFZ3Z0FPZ2NLSG96ckpSMHBjcVQ4ZjM1M215UU95Uk40?=
 =?utf-8?B?dUVSaVJFdkYva0twbCtpUVRkMzMrV3FQL2pGWnJHTy9TbU1pejkrMklPNTBj?=
 =?utf-8?B?QnNkRStkSEZvMVVYQ3NwOFpMSFI3ZWNicmJkSFdYT1hOUXU2MTczM2VxcUh0?=
 =?utf-8?B?dWVYaFdrLzE1S3pRV1I2aFpBaC9xNmxmQXdNY0hHcHRlZk1ad016eUVMTUU1?=
 =?utf-8?B?U0xxRmNidTJnMTNLZXRJWTRDMkVvcFRONGVLQkVMbkhKaWRPOHFNWUN3Y01W?=
 =?utf-8?B?WXBqRUJSQU8zNmhvVjFGSjQwR3h3dms0NmtYN2thTUdDSXJSajNCZ2lNT0pw?=
 =?utf-8?B?MjJ1V1B2WElLQ1ZobWVOUlBYN1M2UDRROTBEMVdjaldDRHpjbi9va0h3ZHVr?=
 =?utf-8?B?RjY0amh0cTlIb3R6dUlyVUZWc3RhMXJVakJLWTlFenlDeWdTV1JHNzdlYm5B?=
 =?utf-8?B?SmJwbVRubjUrY2dxVGkyTjZXSHM3UmxxK25IYmhTcTRNNjBPK3ZmN1U4Wk1O?=
 =?utf-8?B?VDVleTgyZCtYbE1PNlUxMjZ6VkFZYUxkVGU2K1VheXZoZXQ1TDNKVmphcUVy?=
 =?utf-8?B?YnBlb2plV0JJdUExUHZXcUxhRld5b1FTOHRqd0xoNFdQNERnM1NPWnhkVW1X?=
 =?utf-8?B?QWlQRW5wWkdNei9oaEtWLzFyU3R0MjFhZVd4NVEzUnVDNGhEdUxMN3ZRdFpz?=
 =?utf-8?B?UGl3ek44WTIyMXM1dEJPRjlYNllsc0dSTFNRWEVtQUQxTXc2bzI2UUN1Tm43?=
 =?utf-8?B?VmdKZm94T1N1SlRMU0M5Q2RPdHNBZDNpV0ZxMnl1YjB0UGVQYnBoam5vTWU2?=
 =?utf-8?B?WS9aR3M2a3J2Z2JJSVFCVUU5Zno2Z3Uwcitjakc3S21NNkZMZVdjNytpTDcv?=
 =?utf-8?B?T2thdTJ2Yjk3UDdUK1lHdGlRQ1NWMUQ0MGJJV0p1VmE3M1hWa3B5aXhrRkZT?=
 =?utf-8?B?clkyZDhXMzBMUnliNjk5eDBFdWgwWmxkM1UwVkYzTm1uckZvRDB4aEJ0NUI4?=
 =?utf-8?Q?g2UYtsGxrRvCSP3jPPzApSkgt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd281d7e-67aa-46da-44ca-08db9f810fd1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 00:21:26.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnrgVshD6Y4jgeLtkqkTnNXCpj1i2M+LK1IwCISYwexxhw5rdddQ7mAcSdsH5mI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/18 01:19, Anand Jain wrote:
> 
> 
> On 17/8/23 20:04, David Sterba wrote:
>> On Wed, Aug 16, 2023 at 08:30:40PM +0800, Anand Jain wrote:
>>> The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
>>> where the device in the userspace btrfstune -m|-M operation failed to
>>> complete changing the fsid.
>>>
>>> This flag makes the kernel to automatically determine the other
>>> partner devices to which a given device can be associated, based on the
>>> fsid, metadata_uuid and generation values.
>>>
>>> btrfstune -m|M feature is especially useful in virtual cloud setups, 
>>> where
>>> compute instances (disk images) are quickly copied, fsid changed, and
>>> launched. Given numerous disk images with the same metadata_uuid but
>>> different fsid, there's no clear way a device can be correctly assembled
>>> with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
>>> disk could be assembled incorrectly, as in the example below:
>>>
>>> Before this patch:
>>>
>>> Consider the following two filesystems:
>>>     /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
>>> operation fails.
>>>
>>> In this scenario, as the /dev/loop0's fsid change is interrupted, and 
>>> the
>>> CHANGING_FSID_V2 flag is set as shown below.
>>>
>>>    $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"
>>>
>>>    $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
>>>    superblock: bytenr=65536, device=/dev/loop0
>>>    flags            0x1000000001
>>>    fsid            7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>    generation        9
>>>    num_devices        2
>>>    incompat_flags    0x741
>>>    dev_item.devid    1
>>>
>>>    $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
>>>    superblock: bytenr=65536, device=/dev/loop1
>>>    flags            0x1
>>>    fsid            11d2af4d-1b71-45a9-83f6-f2100766939d
>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>    generation        10
>>>    num_devices        2
>>>    incompat_flags    0x741
>>>    dev_item.devid    2
>>>
>>>    $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
>>>    superblock: bytenr=65536, device=/dev/loop2
>>>    flags            0x1
>>>    fsid            7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>    generation        8
>>>    num_devices        2
>>>    incompat_flags    0x741
>>>    dev_item.devid    1
>>>
>>>    $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
>>>    superblock: bytenr=65536, device=/dev/loop3
>>>    flags            0x1
>>>    fsid            7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>    metadata_uuid        bb040a9f-233a-4de2-ad84-49aa5a28059b
>>>    generation        8
>>>    num_devices        2
>>>    incompat_flags    0x741
>>>    dev_item.devid    2
>>>
>>>
>>> It is normal that some devices aren't instantly discovered during
>>> system boot or iSCSI discovery. The controlled scan below demonstrates
>>> this.
>>>
>>>    $ btrfs device scan --forget
>>>    $ btrfs device scan /dev/loop0
>>>    Scanning for btrfs filesystems on '/dev/loop0'
>>>    $ mount /dev/loop3 /btrfs
>>>    $ btrfs filesystem show -m
>>>    Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>>>     Total devices 2 FS bytes used 144.00KiB
>>>     devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
>>>     devid    2 size 300.00MiB used 40.00MiB path /dev/loop3
>>>
>>> /dev/loop0 and /dev/loop3 are incorrectly partnered.
>>>
>>> This kernel patch removes functions and code connected to the
>>> CHANGING_FSID_V2 flag.
>>
>> I didn't have a closer look but it seems you're removing all the logic
>> to make the metadata uuid robust and usable in case of interrupted
>> conversion, while finding another case where it does not work as you
>> expect. With this it would be change in behaviour, we need to check
>> the original use case. IIRC as the metadata uuid change is lightweight
>> we want to try harder to deal with the easy errors instead of rejecting
>> the filesystem mount.
> 
> Robust indeed. Silently assembling wrong devices-data loss risk?
> Failing to assemble is still safe.
> 
> I think it is better to introduce a sub-command to clone btrfs
> filesystem with a new device-uuid and same fsid (as it looks like
> same fsid has some use case).
> 
> Thanks, Anand

Oh, my memory comes back, the original design for the two stage 
commitment is to avoid split brain cases when one device is committed 
with the new flag, while the remaining one doesn't.

With the extra stage, even if at stage 1 or 2 the transaction is 
interrupted and only one device got the new flag, it can help us to 
locate the stage and recover.

Thanks,
Qu
