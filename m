Return-Path: <linux-btrfs+bounces-420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326377FC480
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 20:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D641C20FBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2DC46BA1;
	Tue, 28 Nov 2023 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dqKcy95r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8610F0
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 11:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikblfPCgsCD1B6lT+aXnL4r9TWuu4D9IoUfm/EaZBBwxR9o9cPWUjgJukA7OqKKfhFJ3rZmsjvkqVyLTbag3xFRc1d065ttHPm7iNRUMh+ZSwGPgJbw91JcZQ3hnEFGlR4Ae/LeEqgZ4jUz5cQQb68oP2eKwZmEaE+mZPZMOZiYY9yi/FuC+ZIgDlNowLcfzjBCwTrjpQTkjLMov56wtt7WRfOfL1/Z4g4CmHEiIqeI4OU3vZ0CNh4g3ozAv3Lv81QALgZsClSoF6wwngv9IFnyFAbwS0f2zgcH6CxPsfmN6C4JznUJgGbLCHCXq4MWmxAcLwl71e63vFOG+N6mdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoohJ+0VIpNAV/cNlqJykeL5W1PH0WWjNo4FgTAPgyw=;
 b=Mfp/4pjVVUBv1hMcXLKub5zVbKhk3OeTgddBPabwHpgDtPOqCgXPwaRh3cEG+DEHI4vscK3jhaGlH5Sr+4gJeHZkBdHqyQPhT604geIVKW+144jgyW8qQa8+3IArkL9Cp/aEXufksk61QvO10tHJIPuzsqi4hqogOXnMhEcGvWcdyC4kRt+LnUZdj6O4QOIzjjdVgBRHwsCs4jSaE2h2Gb6FG3cublIF+sE6ILgA/ofujPr3OUtlo/eZiguV7gwFbwUjSGoTSIy+krFO6UTSHrZ5QkuT/8E/LB9VGIzKFNcusDCNaUb3bp3bGoOXcQNUj4GsyKgqtTL8FmxmbhW6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoohJ+0VIpNAV/cNlqJykeL5W1PH0WWjNo4FgTAPgyw=;
 b=dqKcy95rwnpNJD1f8oS62/ahZ3fRvO3zQccikUnJeCVXMHoZjMnLOJssS/L3IMNwvr/jkKYGQ37Gh1Ds6Bq3wlLa3HVXfTaKXeOTlV9SpDuiND5OmN/V0Yot8XUh/uMsCH+X0scQWXESh5abnCEKA1cF7pp7lDrKp80si6yfxRsvED+VN7ttjOSFnTBzWt1ipoNpA7ImPsxJv0OA2p5xLXU6NfWjn+ddIaCPQbJYeFaAqDa7/JCcJ8MFvz41Hu9aBB0uvGyArzQ8BJk855/78H2Q5zCzHbFhGqGx6XUDc5mWrp2Yvx8Y7F5sY6EjDtBixzXzGhms8daN0Uuw5HFvvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8595.eurprd04.prod.outlook.com (2603:10a6:20b:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 19:57:37 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::62e8:6e:83e1:145b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::62e8:6e:83e1:145b%6]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 19:57:37 +0000
Message-ID: <f229058e-4f5d-4bd0-9016-41b133688443@suse.com>
Date: Wed, 29 Nov 2023 06:27:26 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
To: Hector Martin <marcan@marcan.st>, Josef Bacik <josef@toxicpanda.com>,
 Neal Gompa <neal@gompa.dev>
Cc: Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
 Anand Jain <anand.jain@oracle.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 David Sterba <dsterba@suse.cz>, Sven Peter <sven@svenpeter.dev>,
 Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>,
 Asahi Lina <lina@asahilina.net>, Asahi Linux <asahi@lists.linux.dev>
References: <20231116160235.2708131-1-neal@gompa.dev>
 <20231127160705.GC2366036@perftesting>
 <fb78d997-cb99-4b98-8042-bdcdbff22b88@marcan.st>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <fb78d997-cb99-4b98-8042-bdcdbff22b88@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0094.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c0::23) To DB9PR04MB8478.eurprd04.prod.outlook.com
 (2603:10a6:10:2c4::13)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: f90775b4-a0e4-4eb7-2a54-08dbf04c44fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aBi0+lrPevn5PphqDt6vkiFMAe+kKD/dQFbZJH6d6yWakPGJChsvJE2nRwCfG6Dn8RJkp3+0Fm/FgH0hEMl84YyEo6ptF8Uzeo3MTVCVjMWjJ/b9Y2n9fcOe7fD3ULWeDsa/4XeVmhrreex1qdTI1Idy0BE/W0paI7YlTpWyAwMugAlzHS2WKOfiJx6bcHMm9I4W8UYqOiYKYsVZLvKvN81pPR3THuCIU9FNm2SO/vMhrP1AOVe6FaMitxeIKJomJCTbvfQBLH0q0YcWyYDMZR1kcZRasCbv3sVHoecCWQXpUqPnY64h5JZ5WtyzEh2Z6C/Sun++F88PiDxNX71Yop8GjSMcE0Ikc5IudITpY/2S3Ri0n66LxqzVQpCvdMb66MESTIQ4K9GgUf7c6RaRzDcrdgd57CtJVip9PHHf9l79lyN/qZ/L+dCnFldI9w1oTFg8GvYBAchP+/6xCk/OpFFHbho/b8D5hjhi7oNm+vSNiBj9WgA29QxW9IYRfNM65JYX6KW+ddYjqo1d7uj9TQGyjfLe6Xy9cGrilULjujNVERyEbVylh/AREQ1xfRy/1EzpaE47pVJ+6ijIotNQn19odtDT+1IZFGWXlGmoM7dEMe/qmt8NRCn22grJ1hoa8fQahsvAbwKQzg1mQzcZcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(6666004)(7416002)(2906002)(6486002)(54906003)(66476007)(66556008)(8936002)(316002)(478600001)(4326008)(8676002)(110136005)(41300700001)(66946007)(31696002)(83380400001)(86362001)(31686004)(38100700002)(36756003)(26005)(53546011)(6506007)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGpLYlZMUS9Wbk5YVGJ6MHJaM0YrM2oyblZleXYvTkZlOUoxU1hLQVhPZnQ0?=
 =?utf-8?B?bWFDT1BaZE5zVnd1am5ac1dVejU1bVRQa0VjNk5SQWs1Vk40YXpNVjlmTjdt?=
 =?utf-8?B?WVFHQXhtWW9veDNTbzNGQjBGVVhpZTQvS1JOT29FNXFaOUcrRkl4dkRNZXpi?=
 =?utf-8?B?UlFKZ1p0VnZWMTVoNWJjOFlnNFlGcitOcUllYytkNGY3UHFZUjlIbzFHek5y?=
 =?utf-8?B?V1Q5VE5CcXdEbk1ZeDVkZmJEdTc0VmxUNUFmcHBJRC94SGdTYWtIeDNJYTRY?=
 =?utf-8?B?VllnSVhGcXZhUFhqUGxhcTc3WDFGV2RjZG4zY3Q4TUI4Qm1nTmxnLzNEbHha?=
 =?utf-8?B?WlRmMVJyV2lsS1NzZkxGcFkxOGxEUitxeVJzNGxFWUVCaWo2dWEzZG5LZTE4?=
 =?utf-8?B?RVNhZ3JWSkNFdWQ5YVoyRHNIUUZ4U2tHS1BneUsrSUs4WmsvNk1mWGhFZFZs?=
 =?utf-8?B?S0NaRzNGZ2QxcmdyUjBPalRsREV0SDBLaVE4bUNaL2dhdlJXbHhhdGFEdnB3?=
 =?utf-8?B?Q1VISEMxNnIzVG1KaWhaZjdVMllmd3U5RFZPditLNFVjWXNOT3c2TkNyNjFa?=
 =?utf-8?B?NzlYVEVVWDY5Z2EwUlMxMkZpOFFodXhRUFVsdDVnNEE2OFE2d25Tc0J2YXJZ?=
 =?utf-8?B?Qk5Hd3NrVStEQW1pRmp5dW1RckpuNnk5NXJZWWw0NGZSODAxSVpNRWNRbGxN?=
 =?utf-8?B?THU4QXpKYmFQWHNjNUZHekczWTVBcU9zOGJtbkE4cDR3SlhHSUtuYXpLUjB0?=
 =?utf-8?B?R2dieHFCVitNYjBObnhjRzh2UjN2bnJmajBxMkFsMXVpL2Z3Z0c1VkpTaE9w?=
 =?utf-8?B?bHp1anlac1RUV2tjVU8zZXlQMGZJdWJZZHRGVkJIdWpsa1Baci9YWFFtZGZp?=
 =?utf-8?B?TjlPakkxVWRjekhCMERFcmN2ZnIxeklkUXhJOWU2eXh2YzdNdEVPV3JvOUQz?=
 =?utf-8?B?VHFLZmR1Z2RwQ2wvQjIxVHhNeDZ1R0FyeTE2UHJHUUlLQTR4Vk1qZXlPUUVZ?=
 =?utf-8?B?cU1wWWV0TkpoU0w0SUJsVmoyOStvcmY2ZmY4REVvRHJhNzJBUzQrTlJ5VTJY?=
 =?utf-8?B?eFoxbytrZWJTdTVJcHIrdnd3eG5scTBRU09GYmVLWmptWkl3ZGkrQTk1dU1P?=
 =?utf-8?B?djhlZTNZRnJLOTNBSTA0L3UwRjlXWktMVlgvZk9DZEY2amdmcmd0cm1IeDZY?=
 =?utf-8?B?UVRIK2tGZitYdTZrUHI3THZpbmwyeGFNcEhlVEZVYnA1ZWZnamk4VmxQS01k?=
 =?utf-8?B?c2NmZ2NMR0pxYlYvd2VXMkg5RDhRdEpVMnppdHNnbElNZDZGSUJwYVducFE5?=
 =?utf-8?B?ZE1obG51QWc1TWdNWGlRTy9mMFdvaEY5SGRGdGhQN21VSHZhSGFOSnpDT1Vz?=
 =?utf-8?B?ckFtTzRIdkd1Rk5GZS9LcUo3NDY3WHRMMzVXWk5YWTBQTlRjR0VmS09tNHVX?=
 =?utf-8?B?RlMxZ1oxOWNtbnNPTmJNOFV3R2ZLOTZrOGtRaUhBTjZ4MzlaNytrWWllaDBI?=
 =?utf-8?B?U1QxelB0eTJBNXEyeGV1TWVBak0xaThadlVrVmFzeHpFMVBoWlhobGZzcTJS?=
 =?utf-8?B?SHI3ZEJibmVDbnJYaFlsNnlReEVMU0ZFMDBicmw0Mks0czlZUE42YzlvSEVX?=
 =?utf-8?B?L2JFczhnaEpsMkNnVnJKRHJZSWlwUFBJanAxWmRYRDlkNlRXZzNBa3JFRTYw?=
 =?utf-8?B?V0ZZRG5YV0NIYXBSaGpuQmN2emFRSjV0SllLRVBVWitVNHRFREZMbDdkUTFa?=
 =?utf-8?B?WHRZbnYyWVgzSHZGUFFYWm56ZjJMbHIrc25qNTZ3RTBuNnJRcVJrQXN6MS8y?=
 =?utf-8?B?TFJGV0JXQm15T21qOU80TEltdjlQZzJGdVRLU0ZjU2l6eUpIbHBZaVdORHdL?=
 =?utf-8?B?ZnJOVHovaXdIVEd1T1pDa0N0TUpCNks4a0w5ekVTcGo2cVhramc4MzVPTWNr?=
 =?utf-8?B?MDZkY3FJeXVXbEg0TlpmWUp2SUVva1ZnODVka0pCeWVWMEtPN0lnSVZVbEdv?=
 =?utf-8?B?NnZYcTE5Nk9SM05CTlpuZllnRDA4RkJGMXd5WC93ZEpjbWErR1hoWDk3NzBU?=
 =?utf-8?B?ZGN4UDZ0WktENGFEMTNranhqYUlNWnJ2OHlocUtTNURQMGM4YkUvdDZWOVcz?=
 =?utf-8?Q?rST0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90775b4-a0e4-4eb7-2a54-08dbf04c44fb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 19:57:37.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJhVI1BMKSOsC7vkrQHL+rHXgKAZsLE9FwQ0MjPExlGIsBLzp7V7jWndi5JylnJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8595



On 2023/11/29 01:31, Hector Martin wrote:
> 
> 
> On 2023/11/28 1:07, Josef Bacik wrote:
>> On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
>>> The Fedora Asahi SIG[0] is working on bringing up support for
>>> Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].
>>>
>>> Apple Silicon Macs are unusual in that they currently require 16k
>>> page sizes, which means that the current default for mkfs.btrfs(8)
>>> makes a filesystem that is unreadable on x86 PCs and most other ARM
>>> PCs.
>>>
>>> This is now even more of a problem within Apple Silicon Macs as it is now
>>> possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machines to
>>> enable performant x86 emulation[2] and the host storage needs to be compatible
>>> for both environments.
>>>
>>> Thus, I'd like to see us finally make the switchover to 4k sectorsize
>>> for new filesystems by default, regardless of page size.
>>>
>>> The initial test run by Hector Martin[3] at request of Qu Wenruo
>>> looked promising[4], and we've been running with this behavior on
>>> Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
>>>
>>
>> This is a good change and well documented.  This isn't being ignored, it's just
>> a policy change that we have to be conservative about considering.  We only in
>> the last 3 months have added a Apple Silicon machine to our testing
>> infrastructure (running Fedora Asahi fwiw) to make sure we're getting consistent
>> subpage-blocksize testing.  Generally speaking it's been fine, we've fixed a few
>> things and haven't broken anything, but it's still comes with some risks when
>> compared to the default of using the pagesize.
>>
>> We will continue to discuss this amongst ourselves and figure out what we think
>> would be a reasonable timeframe to make this switch and let you know what we're
>> thinking ASAP.  Thanks,
> 
> Reminder that the Raspberry Pi 5 is also shipping with 16K pages by
> default now. The clock is ticking for an ever-growing stream of people
> upset that they can't mount/data-rescue/etc their rPi5 NAS disks from an
> x86 machine ;)

As long as they are using 5.15+ kernel, they should be able to mount and 
use their RPI NAS with disks from x86 machines.

The change is only for the default mkfs options.

Thanks,
Qu
> 
> - Hector

