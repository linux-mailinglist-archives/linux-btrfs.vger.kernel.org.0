Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728F13DB7D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbhG3L2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 07:28:10 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47268 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238659AbhG3L2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 07:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627644483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6WNl4lSACvWtkmXOk7mn+QTJTrLVpju/QozLazm8tI=;
        b=SgFYGxSxlY1m/JLN5pjcj0IPpvNBEzMfU9j3mVgeGgHo/G6w+L1VGsDGx7TwGFI2RPzSoe
        pzUVaOJHVtNE5TKA4AQ2isPbnF+kNfL9IiIce5QpLMhIhDqgyDmv84JO4FEJR4+5IquH/O
        sAxGNueZMbEAw9iUved4W9NstjSEvlI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-ez4IwKo3PhyB7hJG744-HQ-1; Fri, 30 Jul 2021 13:28:02 +0200
X-MC-Unique: ez4IwKo3PhyB7hJG744-HQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obwk893VSUI4/JVBoPAqIn9DAxGRpBY0+Bt91y0VGkCGWtdit0m7gmikbsJc/HY0hgxtz/aPlA50W4/v8cJI5fWuRE+hUxcDQBGkXZS5fZ7y+YhQSXtC0hVPQbMyyr63g0E3Cl0Y/+86YrufpgXQjsnVNplZ1o7KKTIgGmLuG3SR6tH238LtqSrzFlUwXxKrgyyiip3aqk5wsN6kquQRMPUiUzdqRbqFU5mxZjfKeGr++oh2n9bic1QL2WwPB7BHxSOVLW/TWV7m8+8wwSlYai3PULI80bzdIUecmtcIIJ77bzM6+3lMnd0aaBcJZL8qaZTd1SQRnTbx+V7KY7J0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBv0RXd057rQviomJF9nPNagtdaK7DK4/w/fivDmfoM=;
 b=lnE5WJJejNo3tW8ZamVIaaSbECNDhd0SQaeUTRvzO7pvGHr57jO8kap6nxtFOrTq7zgiEUMi4jWGP5GeIao2EhypC9gBzPJ+4O4s2i5VXLcUWTrLp+prMA+E6IVJJdqvFtCQEORpxCIXl0XeIS4OPBSl3uMif06e3d9BpvaeGQnlIMECjomn3EdLAGWyh4rta6u6PuxOkkj7a6WNnDHkbcPuTOmaJahV2Wv68ncV4ZBdcJ9x8InzwlpuHAUNfKudmnyjbkKKkaXIIr7Ui2ion0SwttLQzjTw+m8OPKrZzSN0JKuVK7R8y/+VGXKtl8D000QmrWlePw2CEGg5EcglMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6181.eurprd04.prod.outlook.com (2603:10a6:20b:b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 11:28:00 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 11:28:00 +0000
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210730055857.149633-1-wqu@suse.com>
 <20210730110805.GF5047@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: setup the page before calling any subpage helper
Message-ID: <248d9d63-f078-0e34-36ea-b1ff5cd63627@suse.com>
Date:   Fri, 30 Jul 2021 19:27:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730110805.GF5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYXPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:403:a::15) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYXPR01CA0045.jpnprd01.prod.outlook.com (2603:1096:403:a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Fri, 30 Jul 2021 11:27:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee32295-9297-4a91-c992-08d9534d166d
X-MS-TrafficTypeDiagnostic: AM6PR04MB6181:
X-Microsoft-Antispam-PRVS: <AM6PR04MB6181E87795B7BEFE1F26FED0D6EC9@AM6PR04MB6181.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dlzReok5TglbXilNXynZ6CBZK7YdqFdpIHH43L3ybOOEPcmKPE+tgZhpA353s2bemNRkPOSfaFOVkezG2ar3qLpK7jl9BZvJqlTg3Nx93qDpFuGJLKXsGc4llLoz63s49f4J5pHn6CQEeGA5a8YF5McuG3r7eFpAIzea/9uUa10IpZ3F7A2VK14BiLiLm41n4tO6hU8GBk8oaa5snxRegrsWTgSdM+tL1fid6KnX/cBDC6t7QNotgHXt7KmgjXfCbRMd7eeJF90krtMSxEu8BjbYuZ90OJTE3eUOccdLExswujywja3irE6+8S7vrZn0RWQF8qszaGfLi6IhZJDnprnW5p75tU6xW7I+exjjF1VFyWbQh+ck0GBXFFMncZ92Q6jCgtBx2od+i1gcTxXY8t1FauLnNGzuevkX9e6nems0GVxelbaH5aPXkqxUxDI+7mEsFhtp3h4n1aIN/1YvOqQzNYFs3CvbRcdSTLBv+rCr4Wi5PWAqKDj03VYnrBozta8lVgwA4hISUKAIiATEERAsRkJcEAxlimlkczqG8SU1fFK54kLzNDu3FyT+h27Uc4ZwvTFEoszIlcAJqGcOM3cGBnHnrmbMtvKitliEFwVi682FZ7vRmwVE+VfJexAQkGBglMSIMAIVmmfP5oAXVXE+7F5CAHUsZ0/4h0D/xWJwcV6Gz2bXLNpNcBs82EAgRoXJizv+pNO9Ja2WQ/S92K7bhcUwYSYxFNPYMb85kUOeCiJlka+f7hRwpJAO3wVwq70Yskl9LTkJZWSr+hzwBmZ+CEHu1JeJ4zscWVZreblRRNVCjblKXV9B4GMOgc83u0/PpkR47LMDS//sLOURg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(366004)(396003)(136003)(55236004)(6486002)(966005)(31686004)(956004)(8676002)(2616005)(8936002)(83380400001)(6706004)(38100700002)(478600001)(2906002)(26005)(186003)(6666004)(16576012)(5660300002)(31696002)(66946007)(316002)(86362001)(66556008)(66476007)(36756003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7S25vtwRL4MvwcBpzF4DQKyfjym6Ch+tgVk6tvCgrd1HkiI0ynMXvbpVF/pY?=
 =?us-ascii?Q?Ytc4wn/y5XuAJQHevoYQoF9Ci/8ruOMmNXJOS+RjwwwbA2KEoCNyksxJpGqQ?=
 =?us-ascii?Q?tJfuJhIqiGkoHVtAMUWYcW2wSOuGhrPiTwGF8LWAcbme9eNgABFkpJ/MN4hb?=
 =?us-ascii?Q?LJetvoVZ8msb+TLCbSnq+ELcpW7CQEu290botqNWdG8CmH9BRCNl87in6V0d?=
 =?us-ascii?Q?O1EtBubSR6vYW0VifyIbLy9qJy2HUvx0bXhhr4Fvi0kQLFxnolv5MLMAdk6b?=
 =?us-ascii?Q?9XoaOOLClXH1wMc0Ou9QcA0rWqVVa6SOHyiHzFYPxepfe4eE7TfaSpOmGR44?=
 =?us-ascii?Q?IUMLC01GwKiLkn4s0HPN37upznD3rCG8PCFTNiaSW7ovD3kARqAmjz9Xqmnr?=
 =?us-ascii?Q?hBbF3pOSgiXjdm31ctRD/QbAwBxe2lwx8z1ZivuO386tprGHXyGRlpYGkCS2?=
 =?us-ascii?Q?ZTDz+LOCtqzlSYqaI8DMo55fY4VjIwtLsLmURkFrg2dZMysqktJ8KPKDC9qv?=
 =?us-ascii?Q?YVSrGGH8ulTKke9YtsvyuMMflLetzTmU0MJi99IjkZ0Qt2IGWAAnqo2Y8+of?=
 =?us-ascii?Q?4xtQ9ISt/Sb7oX8Hl1E9yBj/gZNG+NWodsVxadBlMasEkSTjPW+SIxN0YI0q?=
 =?us-ascii?Q?TFquvejfWM44ho7/H6E+Fmf2sZQgezGEG6XKse/UDzPUSx9bO1NBCpvTK8FN?=
 =?us-ascii?Q?eTDpUtHfksndYH0ahzyzYzoVv50+kJ9FHLZ7r3Z/Vg+I2xKFOkwDIKc/Ovir?=
 =?us-ascii?Q?SZNtwh+I+5JlT6dCYmqV3LyiFSMbNzpXO7Hvr5KBDDTJOFv7bn/LzKm8Js3U?=
 =?us-ascii?Q?WKhPDNQGcfEc2+EW7aDGXibpFfCVRSBMRmPA48Ykg4GH0PpBRhrm6ruOtjnD?=
 =?us-ascii?Q?jgEgMCZiY+5FX8N81QrRI8IcipYVLXsYRNx7FALSaikViVMsf2M/ZUk+NDDT?=
 =?us-ascii?Q?zfMXKlCRleclUH7ph7OTee4nUKEVR9IP0AsTRq3r3RXnapWpK70w0lSh1HdA?=
 =?us-ascii?Q?eXTS+NvmvXIwfst6jqIfDtfRIzs9Fvy58GJg3MVDcBvtROjTE//kKlZph3x+?=
 =?us-ascii?Q?HLL6ijRv2sYBbygEKeoKgebtLnauiiySfIBOVjUHbwcgV0aA1nDmzhwvT3/h?=
 =?us-ascii?Q?EIa1Uz1OP5k5/7LafawNCJQj6+jI7rQNac7lyXaVW3yQpSBYOsdddRw1JEYm?=
 =?us-ascii?Q?2Be5yuxh70MITVEd+6gOVT45jmQ4q4eDS2zFAy/rKC9VZI1U9JgxlQziW32D?=
 =?us-ascii?Q?UArAp2HVesjL3CjO8eQWUOgx6ipKtY5Dp3gA9yPPM0RRf8So/YBG+wzBV2vK?=
 =?us-ascii?Q?KJxF+ZUVTVVTiYK/Z58lByqa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee32295-9297-4a91-c992-08d9534d166d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 11:28:00.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRG9Qd8v60CpViHXB3bNE2yq0G9s9jIfMkK8vCdyxAKilHd0zAUhJdjoriSvv6hK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6181
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/30 =E4=B8=8B=E5=8D=887:08, David Sterba wrote:
> On Fri, Jul 30, 2021 at 01:58:57PM +0800, Qu Wenruo wrote:
>> Function set_page_extent_mapped() will setup the data page cache so that
>> for subpage cases those pages will have page->private to store subpage
>> specific info.
>>
>> Normally this happens when we create a new page for the page cache.
>> But there is a special call site, __extent_writepage(), as we have
>> special cases where upper layer can mark some page dirty without going
>> through set_page_dirty() interface.
>>
>> I haven't yet seen any real world case for this, but if that's possible
>> then in __extent_writepage() we will call btrfs_page_clear_error()
>> before setting up the page->private, which can lead to NULL pointer
>> dereference.
>=20
> Yeah it's hard to believe, but it's been there since almost the
> beginning. Back then there was a hard BUG() in the fixup worker, I've
> hit it randomly on x86_64,
>=20
> https://lore.kernel.org/linux-btrfs/20111031154139.GF19328@twin.jikos.cz/
>=20
> you could find a lot of other reports where it crashed inside
> btrfs_writepage_fixup_worker.

Well, over 10 years ago.

But finally I have seen a real world report for it.

This makes me wonder, wouldn't other sites like iomap, which also=20
utilize a private structure for subpage bitmaps, also hit such crash?

>=20
>> Fix it by moving set_page_extent_mapped() call before
>> btrfs_page_clear_error().
>> And make sure in the error path we won't call anything subpage helper.
>=20
> I'm not sure about the fix, because the whole fixup thing is not
> entirely clear.

Indeed, but the idea should be straightfoward:

Don't call any subpage helper before set_page_extent_mapped().

So that such page without private get passed in, we can still handle it=20
well.

>=20
>> Fixes: 32443de3382b ("btrfs: introduce btrfs_subpage for data inodes")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> I really hope we can have a more explicit comment about in exactly which
>> cases we can have such page, and maybe some test cases for it.
>=20
> The only reliable test case was on s390 with a particular seed for fsx,
> I still have it stored somewhere. On x86_64 it's very hard to hit.

Can it be reproduced by S390 qemu tcc emulation?

And by S390, did you mean modern Power8/9/10 systems too?

>=20
>> In fact, I haven't really seen any case like this, and it doesn't really
>> make sense for me to make some MM layer code to mark a page dirty
>> without going through set_page_dirty() interface.
>=20
> On s390 it's quick because the page state bits are stored in 2 places
> and need to be synced. On x86_64 it's very unclear and low level arch
> specific MM stuff but it is still a problem.
>=20

The hard to hit part is really harming our test coverage...

Thanks,
Qu

