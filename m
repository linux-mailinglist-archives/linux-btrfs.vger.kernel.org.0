Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA44743C03D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 04:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhJ0CwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 22:52:19 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:25674 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238561AbhJ0CwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 22:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635302992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHwOnFlB2dMqNa7IabUvwQZiQfaoop7lXaxBdlCBwfc=;
        b=Z3jRgs8f/Zal9VpRythmspy9DpEX4VGt+SWpqOo0pvsLg4z/EzBwKj+j34DsjOm7Q69F0k
        yRsjuD8HtDxqHfkM/TryZaedZnpkquJVpUuOckX5Y0tSd6gPOZh9sj1sqTlb7nOKtqhlM2
        HGVDgWTKO9lXitiOYiDOseQfM9Yi7/8=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-x9jAzTZ8Mgywr8vE4600Qg-1; Wed, 27 Oct 2021 04:49:51 +0200
X-MC-Unique: x9jAzTZ8Mgywr8vE4600Qg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA+8LGFCnlmmy2mdo5GDnNTXBKpnnFH36aPdXzoinZFVdqTiB8EutuABQ3ECkBWtC5RPteZmt6rolA5Dikd9jWx2xgYx1qbeRJpUo8v3mBGLk3UYWwXOVq3VNpbaaqZElGL7DzPHXYs3argZM/7PcdSSrC6wv9ecPgEhRABE1tWWVW/Zggt8RjzFKAQCBnw32F49h9LLXngKU48wGzPKVeOS19iS/mY8vhls70HMwpqyaa8ntlYYcEH5p/b9aRYgC4yaEHx0jb8sCLU1a/s4rpCXRZwRkZmY+WNJ9H8tXrSM//JZTwPz8XrY/j1ag54IpHK3O1krhu18nYNwovm3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKU0z3hlf73TeP9nVy2csZ/WVTOUEh/4CC3yVN5JwwA=;
 b=ZUsNgsnbK5ZUzeQh2pBUYw46Mfov+I+XVVXCFFaR0Cp/BaTbMbe6rOEuglh+v6IssjiQFX5ac77iiNztyDSVrt2O2VQupQFx+owQGgjTUVR30neIxT8+XDIRXQLDHpHKmYOG0f4VYx8dtMZ2j7lmBmEyDsrw67TxCS1zIg7N2wigaRF6oZmtwFu1BN39HEszeCCk69QP5T4DT5YnisMSY7QHq2TAnQVrt7+Rg/nOv9YNGB7k+9aUIkZfwDVwWLxxRcG+aswzVkTOqd+fDWu70LgPTVFAq0adc+SMBacPh9cR1UjZdVQwZ4QWnCrsWF/41mhyxO3N+flTmzRWZ2ittQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB3973.eurprd04.prod.outlook.com (2603:10a6:209:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 02:49:50 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 02:49:50 +0000
Message-ID: <1c5a9788-4b48-33b4-4dd9-9dd089250770@suse.com>
Date:   Wed, 27 Oct 2021 10:49:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Mia <9speysdx24@kr33.de>,
        Patrik Lundquist <patrik.lundquist@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
 <CAA7pwKOrgt6syr5C3X1+bC14QXZEJ+8HTMZruBBPBT574zNkkQ@rx2.rx-server.de>
 <emb611c0ff-705d-4c01-b50f-320f962f39fb@rx2.rx-server.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <emb611c0ff-705d-4c01-b50f-320f962f39fb@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 27 Oct 2021 02:49:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e16e9407-612f-4b51-1491-08d998f47229
X-MS-TrafficTypeDiagnostic: AM6PR04MB3973:
X-Microsoft-Antispam-PRVS: <AM6PR04MB3973B097FFD5F6047A7D68B9D6859@AM6PR04MB3973.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXLkC25tArl12KfvQYI/un37EVhX9QdZAhI6wUm3eqHXFexZoB/69ETG+vEuItV3UGfS5GwG+SoMQur1XGtCN6CNAePxdDT4NgFkxl7WedQPvfdJUZY4gnn6VtedJXxr7ir79q5HS7y2wp5s6CCILPuqD9U7NBHYpHSaQoTaOW2HVGx6p7kb657U8mqMR+GAdSvtLcVraVyKHRuPK5zJVR0EYfBJf9hrC6VcN6Lkz79F2kYazwafTlnmPKY+cdUMlV6/r8PDXnKGY8QIb211fVPw+Lkp1cLt67tqLpgmYuzpTjvoeHY8nFJXUK65M5BOrtZ9dFMFRNK2QIqGgUhJbr0FLAXCeyY+DMV7NdL2etAqbrz6BdxkMQfqod5sIJx+MSSVo7gy69zrQkYsYDYOqnskDJdeXAfPsu8YkmP5fySVmSsqNy+ECHvG4sWM0tRnCtdQ65trbkm6hHnGMfLqkjW2AOab0ODojGe38H5mWfN9uIjSufK05TGC6cKdKjPmj6/+vBlIiUynH5KhIz+Mv7jRJX7TluSZoIIugTP0ef5Mk8MKghC/Rc1ns0ZRflPz7mDiAUaIVS630OU0M5QBm/DVIQEN6U3v7TOCeov+IATO9S7WBNhyyGUvmMj4Y3j8b3RqqxXdM6lnFQ0TjrNAeDVYs1n8R/KdLP+xgTI5Sa38a3KMxSkmjHxG2VDvr/8mg9Ic8PXrd2PwAQcLXJ+Q8/yUJ9GfIM6GH4OlipdH9Qk+M16PUQLxhdOnqI0+z2vLrauSC/EeH1/D9yVQ5pBTlE2kNUUENxXczOQdZfd9DK/1WfDKRHoQB7ajIbs7W/mmZXDLV+eRVfaR5LigVm7GEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(966005)(31686004)(6706004)(36756003)(956004)(66556008)(83380400001)(110136005)(4326008)(16576012)(66946007)(66476007)(508600001)(31696002)(86362001)(186003)(26005)(53546011)(5660300002)(316002)(2616005)(6486002)(38100700002)(6666004)(2906002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PUxoeMiyFSKHY0iadHsauff85zRZqWOG41pxDMt7qjAq2D3vH6RHawVkCMKr?=
 =?us-ascii?Q?3Cfzp/fS1SzWDok03OZJGLvcUV2aY0Le6AJUsi7o4w2BAKAUi8c5mwoRSizm?=
 =?us-ascii?Q?SLeBBIC2NWvxjjU48nJW7cBf4kR6bzMyTPCOaMPe8Rm6/wQgt3HHhCPoO8L0?=
 =?us-ascii?Q?BUQSvXxPIbogJUr84YY9a+t3/9zOIsyBwETYHQOSYjmAKsU/U3Psp3VLUxqN?=
 =?us-ascii?Q?ve5y8ZixPVKeRa8Byuze2kIEu85wL/OPgnz8+RxqLZAw2KN9nDhyV7huI3n8?=
 =?us-ascii?Q?NrQm6S1j8DcYXOGIBjle/qIo6AYgPMNB91qA5lJDM6L+BZXyf3et6tmJF9d1?=
 =?us-ascii?Q?3U6e/zRLT0x0Ml76nhV6VxhuDnE5DFOZm4Qz7Z97DCBnHZk21h2vaUIQVQZX?=
 =?us-ascii?Q?7BqK7mEHNeQOixAcVntitBr+pCFX9GYzz2D/KFUFToggUORYCHrlZYyA9mt4?=
 =?us-ascii?Q?bwWmnMSossnx4ewqNID6bFPC/UnEFpz975GNsSvTxldqKttQUu4EwpVXO6MG?=
 =?us-ascii?Q?l0kvBdOmCR7T7h1M4yt2mf03y/WBYf6gT9/FRj2xNDcfcxoATsxYeuTBlx+N?=
 =?us-ascii?Q?4jRAalv86q12OD8K9vygqJIMpN3GuTX5x0wLqgDsUHMFSuRjdWKIt8Iou4O4?=
 =?us-ascii?Q?vBbqggVUzuqBzqY1myViSz6aVZTDZ5riQMeG0/oCksIGR7sABtwocjLBmyCS?=
 =?us-ascii?Q?vdhIAVbjt122FJGIY7sNVB02i349rC+BL0Jmu548yNF+pxo5v6ISYQ0JBsEm?=
 =?us-ascii?Q?M6BX4ASrWSFhDuYFUBDijJmg6Tj192ulZIeYs7YD3MNjQI60PK/2yIjPWLF4?=
 =?us-ascii?Q?sIdjkWbJO8F0OyHtfheQgE3me+UQ5H6noDTY/Ct3BTjV8w46XzYUqvwN8fd7?=
 =?us-ascii?Q?1ai2IbUC2vrBmskdjgz7I+sqxKPQhwtxYOKRevcBqk13KfJTrcCLdfNavwyv?=
 =?us-ascii?Q?SvNe08rrmdJJ01SWoF3Zq8XhkOuV9ydIjliQV1517jOh0AoCVetA0jw1ETXB?=
 =?us-ascii?Q?OmPmZcDxQonM9YTSFbvF+YvQZFJZkbS9FFWmVSbap6HlGxmb29iqUETexZY9?=
 =?us-ascii?Q?WbD4/0QkQtWU2cPSFK3IW005pF7xpNvc6tCCGsXbKLrVbJ1/gIGEjbvZDKxJ?=
 =?us-ascii?Q?9v2/TCYAfk1LOh7Qc2De4KmIzI1mC+zHCDE+LbewqoVJ2FFuLsNV2eTbUi8a?=
 =?us-ascii?Q?m5IPFqVltw4XLazInv9XdMX0lQT0PcswQmYCGAOjOIUUGSLxm8SAjRUVE/LV?=
 =?us-ascii?Q?aml6w8qDY12mtM462WBtYBw8wxNJRPegZOAMR74lB4aU8ZLlDeFFL5oQgS9d?=
 =?us-ascii?Q?UB1OfTH+PsZxRjDgc3jRu7jitmu+hr4x+I4mLBl7+4Rq8UNH7Ab3NBpyusny?=
 =?us-ascii?Q?XBJlNkXgqkuBhm1iJDQgGoH3vklLg9+/wH7WeuINuLpCSVWyebzA6NO3Tymh?=
 =?us-ascii?Q?VygvKTGH1Ct2MAIVQClaBOWGUdkPh5GqYnJesyQkHNgPuGJ+/U/Bk21P/k9Z?=
 =?us-ascii?Q?cZw2PuKQ08p14jkT2Cr3ermby+Sig34Rw1jymXAnrWHdWaRd4k3xuzH5Pas3?=
 =?us-ascii?Q?kZCta4u2BUOydFERSCk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16e9407-612f-4b51-1491-08d998f47229
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 02:49:50.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUxC/+hfyc1KR4GhKyB8BDaRYFQHX/B4pLJYyqRd0Rnftwbbmetp6VgYi3Edd1Ir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3973
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/27 01:28, Mia wrote:
> Hi Patrik,
>=20
> good suggestion, I'm on 5.10.0-0.bpo.8-amd64 #1 SMP Debian=20
> 5.10.46-4~bpo10+1 (2021-08-07) now.
>=20
> Hi Qu,
> regarding the memtest. This is a virtual machine, I have no access to=20
> the host system.
> I don't know if a memtest inside the vm would bring legit results?

If the host is using ECC memory (IIRC most VPS are already doing that),=20
then no need to bother the memory bitflip possibility.

Thanks,
Qu

>=20
> Regards
> Mia
>=20
> ------ Originalnachricht ------
> Von: "Patrik Lundquist" <patrik.lundquist@gmail.com>
> An: "Mia" <9speysdx24@kr33.de>
> Cc: "Linux Btrfs" <linux-btrfs@vger.kernel.org>
> Gesendet: 26.10.2021 16:12:45
> Betreff: Re: filesystem corrupt - error -117
>=20
>> On Tue, 26 Oct 2021 at 09:15, Mia <9speysdx24@kr33.de> wrote:
>>>
>>> =C2=A0Problem with updating is that this is currently still Debian 10 a=
nd a
>>> =C2=A0production environment and I don't know when it is possible to up=
grade
>>> =C2=A0because of dependencies.
>>
>> Maybe you can install the buster-backports kernel which currently is=20
>> 5.10.70?
>>
>> https://backports.debian.org/Instructions/
>=20

