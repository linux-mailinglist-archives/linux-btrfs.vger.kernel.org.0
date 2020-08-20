Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C441724B42C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgHTJ7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 05:59:13 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:60053 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730125AbgHTJ7K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 05:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597917547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7lkTmta/Zt9qoMyxmf4B+giZqOF8Iq8Cfu5PJg6Tus=;
        b=KJQza76Aakg3r8MJx6tfJ7+UTUcwVuCAKIX454x0CBpJEzYTjYsvDL8NsvDkMGxNOEQYtV
        TmWEX4E40T836iiF09FdqYooAnmyokJVgGl3wG3ND1F3SPRLMXInnV5YiEAl9kU87QAciN
        G/tzm3bog6Cql4Ae6sshu8SCz8zGwNQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-uDtnhO3yP8W3b6OW1miH6g-1; Thu, 20 Aug 2020 11:59:06 +0200
X-MC-Unique: uDtnhO3yP8W3b6OW1miH6g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdcF/41KBHu98FYZcy2z7l6heqVDeaAUXSkuMmOt/1rm3oNRnokM7W+GU9/4EPKpnCaIRtiECLZzms7Kxc1Fo06zB9CZtp16l5dT8/FGylIl7+CLCCcZrVPac0ATEJCm46gkEV6t4Xqlf2IHVYRXh85s4qYSkc2l1XD9NI8bxWBbCsrOIdv6/+1wDBYmmiHasnBZ0qNPWBYhYFKekKEA/JZWmH5GxqogEvlnhb+5mgHS2S7/dZcZk9p5V7GEzXC6oURdV1I6NoY8QYsE9e7Gn03FhOZSQkgEGk4cpfXtHPBfqNV2BTDLCTn0cEVsPfioQsUggnefmrbOfptz8Ki9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVc5PTreIh8Rfeemd8QAl/rZytVsyB+ha5lrfmlGgqA=;
 b=JtTI2tVs3xo9MCatWWM7OeMHYNEiOo2ttzBLkO+Vap6ki+YWmGtPtNJI0gv9gFkL1VNgojwbwhZyU2pR1dWThbiIPUPypH09+5PLLm8giAsm6PQyFt7gjTEXAUHfHGUj+x/3+MBDNWDHAXiKkgiwKb/SFn0kr3NzfI6G1pajHW9MSqDsJrGBkc5gNXSoR5XijT2NpayreplU1U9J1wp7y97LRhvu0PYPKXGehhDTizCEoM5LpvbL+t60sb5mjXA3fqeSCZKAtbyXO5HjU7EeJmiKE874URYSydSp7aqNfGW/IrP/tBoHkcmy9cGs6bI2eB93eg/VKBp4JI8yqeKBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5459.eurprd04.prod.outlook.com (2603:10a6:208:116::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 09:59:05 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 09:59:05 +0000
Subject: Re: [PATCH v5 1/4] btrfs: extent_io: do extra check for extent buffer
 read write functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200819063550.62832-1-wqu@suse.com>
 <20200819063550.62832-2-wqu@suse.com> <20200819171159.GT2026@twin.jikos.cz>
 <66f629fa-e636-6ab5-eda8-5299d996b2f4@suse.com>
 <20200820095024.GX2026@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <1507884d-ad39-8edf-03fd-42e1d10f50e1@suse.com>
Date:   Thu, 20 Aug 2020 17:58:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200820095024.GX2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:180::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 09:59:03 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 816f7f56-f2f8-436b-2fb3-08d844efac00
X-MS-TrafficTypeDiagnostic: AM0PR04MB5459:
X-Microsoft-Antispam-PRVS: <AM0PR04MB54593E39838F366857158C25D65A0@AM0PR04MB5459.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOfeSM76C7fuwtTyrKATaORG5ue/y1sNIvnNN6TfwQsHi9RkNqbBbgJJfgJ0BnmpgutQSUjtQakdY3KY3V6CmAWVV9kX1zW/A1vEI1z+NwCbJI9UHStT3V9Ubj1LKv4F1mwU7h968yvAVvMFQKkD3ULN23LiAuy+5DNUQN3pjU0r60SkoHOOL9/PlZQ9epEk5er9ateGSCjc2nPNJ6c+TOmObVkQJ5gk1w/Y9ZV23LPzK8alRwfUMCRkfDML9yMcAdifbensQD5ejhh7+ZtcA5pakLRFNaQJ5MeQmsf2nJLYiPXubQocWCiJaWI6e+FZQds2RXJ9QE7Ojsw3rkoZd2KyZy6TDlaLWVFttPKrHBUgkdJuQrMX+QisJvsbymaBdpsGuZNY1FCeeVFSZ6m0lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(6486002)(31686004)(52116002)(16576012)(316002)(956004)(2616005)(478600001)(26005)(186003)(16526019)(31696002)(66946007)(66476007)(66556008)(83380400001)(5660300002)(86362001)(6706004)(6666004)(2906002)(6916009)(36756003)(8936002)(8676002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JDOnPbNo6kK++YSYv5yGAWlypDkDur8KNgHj4wkgc9IeMQbSDGgzGLg9+rUexq1T+1PM48bz3a52YFTelKy5DeE/3ScAbtqj51m6b6gDp/RnvARHbjik7j78BdyRjvqwvD/n06AkndO5XuSpZbuFH4HloZEstewcwlcjnjX5IFLOkJMCooHqz3OveMeBbQ6P+DMK8+KKTvK/O8jfGNhBUbgVXs9SjOle2bjyOZrM1qKB2D2XSMe2VxropRGzFlHrXeo3sesvFJzG18B0dJNDaxpFsWv5JkhKk56jxxTGGVZB3sK5qh7cwtjCLBd4SpyZzp3s9LMEIAwNb4dQxZR+Op4pxu5QZ0NwtWh8nxLfqzhToX+6bIaajW32h2g5rGr8yUDo6fLz8qXpaZqlCgxJvx7YvgpWNiAugxOJaREF/hiFk2RHeJkXl8KYGUGcJJZ3OKuSjqJEraVXXEGe8JLwl3oqRUm6iEBjY/Q/sDnBjJWK/hGNrFKEUoJO1EV9u4ITkmknI4QYuPzf3UlRmTQVJ4XW2hld/nZnk2Ex07osrg/XSJoghHP4g3JDepfjRlPPKLTUmMvuiICDXKoZQ+bJ+sdqvqcZqgAl4ELJiwyN2+V8+HNUzHLysWH9LmWFr21wJGFzJGGDakf93htXcmqfUg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816f7f56-f2f8-436b-2fb3-08d844efac00
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 09:59:05.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKEgszPxLHcwtzRmjxMiyVGL6TdF5vE1q6BYi38yVLJ9IoXkeiLMFhFtJu0mAQd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5459
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/20 =E4=B8=8B=E5=8D=885:50, David Sterba wrote:
> On Thu, Aug 20, 2020 at 07:14:13AM +0800, Qu Wenruo wrote:
>>>> +static inline int check_eb_range(const struct extent_buffer *eb,
>>>> +				 unsigned long start, unsigned long len)
>>>> +{
>>>> +	/* start, start + len should not go beyond eb->len nor overflow */
>>>> +	if (unlikely(start > eb->len || start + len > eb->len ||
>>>> +		     len > eb->len)) {
>>>
>>> Can the number of condition be reduced? If 'start + len' overflows, the=
n
>>> we don't need to check 'start > eb->len', and for the case where
>>> start =3D 1024 and len =3D -1024 the 'len > eb-len' would be enough.
>>
>> I'm afraid not.
>> Although 'start > eb->len || len > eb->len' is enough to detect overflow
>> case, it no longer detects cases like 'start =3D 2k, len =3D 3k' while
>> eb->len =3D=3D 4K case.
>>
>> So we still need all 3 checks.
>=20
> I was suggesting 'start + len > eb->len', not 'start > eb-len'.
>=20
> "start > eb->len" is implied by "start + len > eb->len".
>=20

start > eb->len is not implied if (start + len) over flows.

E.g. start =3D -2K, len =3D 2k, eb->len =3D 4K. We can still pass !(start +
len > eb->len || len > eb->len).

In short, if we want overflow check along with each one checked, we
really need 3 checks.

Thanks,
Qu

