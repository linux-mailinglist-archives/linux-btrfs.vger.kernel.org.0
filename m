Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95A2607E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 02:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgIHA7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 20:59:54 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:30616 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgIHA7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Sep 2020 20:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599526790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJXmhZl6p+gZ7DAvcjvRe4Xna/YNcmMvXl6ePCs2/m8=;
        b=X40jySMCXxneW3DpQMoRJK6PoxYiDpTT2Zg+V7I8sGZ0B3d0jy7nYRomQblMTiGOQx3Hyt
        xkYddpvYwPN8zFYG6vpSgU1ScXWT4F3LU3uJLCYh6/zfAoRlioAY9l4+9rRYxPupEO/8Mr
        ytfvnziQhuG1vdNcsMM8hoNpSh0qCDw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-fvMBsIwSM8Kn1-IVTXvOAA-1; Tue, 08 Sep 2020 02:59:48 +0200
X-MC-Unique: fvMBsIwSM8Kn1-IVTXvOAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9XQRBCpPgC9fOii6pXvoG10B60anD4aoC7IyBUcjnDE7U5ulJH/TYO2pqr6idzXrAaMitWpBKWG6FrMN4VUD7fahXneI5b5xDOnrXEWb0+ifXpws1U/6xl2sjLd0Jc2ijIQLQ6Yq9/thw2vLv6rlmfQ2Wf8mco14ijBFhnnX6jXelEWuwLn8F1n3FbHFMi19Hulbiz/aa4/SO3VodZ8jfyzznRkV4jf34rZMOexEirE69WEhQO8o10SQgxUHCiJBaS83POAGCm+q1iipq+G0bFNhxIveSjZWqPqKHH0SdI7jC4yBmhV3YOntV0jn1Fx+Umhd7HCgYYYBa9wZ8OCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyAId6s4d8DMQNMrmyL2MaM+Dv43K+j/iqC6ba68PaU=;
 b=ZQVY+5FS2jmTwlyYiAwr8/L38TKpeAikmYKelSgo7GCqnXNxF/XaNbOPd6pTCyld9u4rVhbjQTHiyZNenZcZVMHspEFL3BkQcBBOzIrnrv0UBTOB+OrNPxK+BJOszW2wCCbe5dWISwoH+vXzrHUznphP6JFvmm55MocdmRCyFw3O/cAJX0Bi5iH2lKhytT9H6UdqtbTCbkAlKXBhj++Q/r68NWy/+49IzzFNlbhlOQeImOcQuzQfhbUvDXL8A5efB8ZpDTvbufCcKhD1Bt6PoKuTY6u5H7nGyzWYUJ2LQK2m5nW0jqA3H6mYmrAmLBgSpvNMufWN9R/MZHerL8TPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB3987.eurprd04.prod.outlook.com (2603:10a6:208:5f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 00:59:46 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 00:59:46 +0000
Subject: Re: [PATCH U-BOOT v3 25/30] fs: btrfs: Implement btrfs_file_read()
To:     Tom Rini <trini@konsulko.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        u-boot@lists.denx.de,
        =?UTF-8?Q?Alberto_S=c3=a1nchez_Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org
References: <20200624160316.5001-1-marek.behun@nic.cz>
 <20200624160316.5001-26-marek.behun@nic.cz>
 <20200907223501.GA11147@bill-the-cat>
 <a88a1a38-8fce-f438-25c9-05d3edd83cf6@gmx.com>
 <20200908005646.GG7259@bill-the-cat>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <9588696f-9013-29c6-c3de-d0fae7ac339a@suse.com>
Date:   Tue, 8 Sep 2020 08:59:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200908005646.GG7259@bill-the-cat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:74::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Tue, 8 Sep 2020 00:59:42 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 219ad5cc-87dc-40d6-47f8-08d853927acd
X-MS-TrafficTypeDiagnostic: AM0PR04MB3987:
X-Microsoft-Antispam-PRVS: <AM0PR04MB3987EB5F5B675A2430ECEDD3D6290@AM0PR04MB3987.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyQrkTVtuQbjBax0X6nC+B89GmHbz9DKEVll+x+DQqwnQqPXV2ySIrryX5hqYN8dcW5zSXHE/dO5bXbO86WuNLqj0hdnr23xpLpcfXNBsKMBbZ/AiSigHbl7Jo445ufzkUYZ+KsZetSLLm4UEgTiJIqBxCRwxUTTh/a1f5UCepdssYwhJOE4FsKevelsYTxFZUG0vT5L3pYwPlFuY1CpsaA87ERKw5E20XeitTGb7q6MBCAvd16VNsiQqjFjcD4jng6Cs/hJG1Q3ZpY8cvsftAOwh/LPldzvzWxJ7hkJZYsy06EhtnKYv//7W/0ZBxC5CpOWyNSj9s+68tAF0vnC5XKz9ZyuJ8qrm/ReB5+NeeXaz94Hge6iA1e7M9q7KafGbUWwzAjmDAw3r4I3fvRa8wg9+DeQ05rY6kmO/rUdPkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(5660300002)(956004)(86362001)(52116002)(6486002)(2906002)(7416002)(66946007)(316002)(66476007)(66556008)(36756003)(4326008)(110136005)(26005)(478600001)(2616005)(6706004)(66574015)(8676002)(54906003)(6666004)(16576012)(31696002)(16526019)(186003)(31686004)(8936002)(83380400001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ELYexaPD2LhCQxZDKTsJmgBDXWjSbcfKuKEpCSQmVy/UXGfM2vvktQOX1Z3kTCUABLZM9Cj2oVR2e/AkYtZyQgelk9dqso1g5Gw836iESaLC/9CaNuH2r5hk8YyKpqF98qEVkgFL1d1TAkRj1mz+zsaTBrlZ2feyEoTklNcrx1U4FbcEXPN6il8QIO3M2+qit78KnGViyAOXuXcm54Zf+Y9Nn/hGXq5zuNpLRVGMDGN5rea9FDUHWcES1UP22zqM+Ve23ayW8u+SBd+85zvGNvj99dPEMvNRX/rk9GJn3LKTK5AZMeVmYGsyMKkh6dhVeUOr9hTgFekQCkoI0RoPcsdFMgE54mPBcUvmKRNlorfbq2bMa6o53E7x84SfRk2b7MYUlZNoV6FCOWYbnhtc+m34hW03K2z8IFwX7pN6Oh5+Oo3EBcKcl2saPI3GvfH7DklzqU8P+7eE/V3U1fubLl7ZIudKmeY0/hvCcnsxgQqkfhPVV5uMyE/P/6NmpiGyOayWvlmbPRdDc2XkBFlYu9rHTcgv90S+Ix8UsoyDMWSRcJT0IktCT3HXZvnNrabM4swoHrnjsaqxo/7G6/YI5sDxfpDpvRqFLMxTDbMDZrmN/FhTjTaMRV26CyqXutni/2e1tRfjO1aWF4X3ucp+QA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219ad5cc-87dc-40d6-47f8-08d853927acd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 00:59:46.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkbuPvYhPNcxFPvOsKwcEbqY2uHj+qIOIZ7o6/7HpToxNn4cbr7h9X5Uh8UwVkv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3987
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/8 =E4=B8=8A=E5=8D=888:56, Tom Rini wrote:
> On Tue, Sep 08, 2020 at 08:26:27AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/8 =E4=B8=8A=E5=8D=886:35, Tom Rini wrote:
>>> On Wed, Jun 24, 2020 at 06:03:11PM +0200, Marek Beh=C3=BAn wrote:
>>>
>>>> From: Qu Wenruo <wqu@suse.com>
>>>>
>>>> This version of btrfs_file_read() has the following new features:
>>>> - Tries all mirrors
>>>> - More handling on unaligned size
>>>> - Better compressed extent handling
>>>>   The old implementation doesn't handle compressed extent with offset
>>>>   properly: we need to read out the whole compressed extent, then
>>>>   decompress the whole extent, and only then copy the requested part.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
>>>
>>> Note that this introduces a warning with LLVM-10:
>>> fs/btrfs/btrfs.c:246:6: warning: variable 'real_size' is used uninitial=
ized whenever 'if' condition is false [-Wsometimes-uninitialized]
>>>         if (!len) {
>>>             ^~~~
>>> fs/btrfs/btrfs.c:255:12: note: uninitialized use occurs here
>>>         if (len > real_size - offset)
>>>                   ^~~~~~~~~
>>> fs/btrfs/btrfs.c:246:2: note: remove the 'if' if its condition is alway=
s true
>>>         if (!len) {
>>>         ^~~~~~~~~~
>>> fs/btrfs/btrfs.c:228:18: note: initialize the variable 'real_size' to s=
ilence this warning
>>>         loff_t real_size;
>>>                         ^
>>>                          =3D 0
>>> 1 warning generated.
>>>
>>> and I have silenced as suggested.  I'm not 100% happy with that, but
>>> leave fixing it here and in upstream btrfs-progs to the btrfs-experts.
>>
>> My bad. The warning is correct, and since the code is U-boot specific,
>> it doesn't affect kernel (using page) nor btrfs-progs (not really do
>> file read with offset).
>>
>> The fix is a little complex.
>>
>> In fact we need to always call btrfs_size() to grab the real_size, and
>> then modify @len using real_size, either using real_size directly, or do
>> some basic calculation.
>=20
> Ah, thanks.  I'll fold in your changes.
>=20
>>
>> BTW, I didn't see the btrfs rebuild work merged upstream. Is this
>> planned or you just grab from some specific branch?
>=20
> Yes, I'm testing them for -next right now.
>=20
That's awesome!

Thanks for your effort,
Qu

