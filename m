Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971E63EEE5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhHQOW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 10:22:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61984 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhHQOW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 10:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629210114; x=1660746114;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=V39SbeiXJLic0eJz3LtXJpR7YlUtgy8hpnjoaJ+Exuw=;
  b=j5CkiFVCLpTUNAV/s9+YKQR21q9/rIMFF5EyMh9LUqmo0imBIpCtFvEJ
   xag5P7Y5FyTgz6LO0rw26yKl0K9mNa6AguNAMhMzzPjzTx5jZnfOopW1c
   isS89P8AZHXaCiMdkWMNhfyk4SiwAu8dVaDEE5Bil9VAMTu5JJhNm5G6g
   g1JTTdHsldUZ9IHYd9h4KIzbPzOskIOZLU7MFpXKT4QXHWX1zeU4GTp8R
   SemZBf3VmTZ4uumtEMh15Revbtulo8vTIdT8rqN+8AlqA4S8NQ1qWjFKR
   eEdM7D/VoWaTrARBbntClJHpVUa+q0vUHttbHmSDhIrDFuAUje8qLqrmE
   A==;
X-IronPort-AV: E=Sophos;i="5.84,329,1620662400"; 
   d="scan'208";a="289107871"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2021 22:21:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SchCowAmF3puHGRCDOHC0F89URtdrwK8QlxTEq4EGq/5K/OmaqF4hIvPOvR9BUtl3wSnu952OuloQbDm66bOj2NPfOagvwa926Wt0z5lI/ppJXfq/NZnCZikvOUFpEm7tgIRxECzDx6vqVGJely9rWmOyVNJBnLsPLVFDj3EE9B1iDYionAIcY0+CIGXNhFVgV4gYg3qXVysBt2Im118qCTT8LV8RtMT6rVi6NMpk9ZsN/FdVkv16lhrinw8HlEC82efO2R/50xxAwiSxLXnX4A8IrOfFmuuTkfOR+crCvTVjGdCAMuvAjNIek0MW18PKhbinM9H/cfaF9kBuE4ORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkE8RIrcD0ylHa/LsbFfALuOcH+e/UgJFuu4hA2uLhM=;
 b=b50xejcOAbBH3p8OuWQiteQMPIDycSa9w+BibMuGsgjfZ8NJqmQ+Dzy4X9YuVcWRSiyag88k1oJQZgZZiyGrtOBv9JUMIlMRrnH9vazobXS5va2mmp4cqrNGCF2WCiINlnFMtyv1BtEbdku21B0CWvxxkxCNS72MyI4wcrmZR7y1CDs2+sClL69NAJT0FSdEmeDSyiB2cYR0DbDu/0mtCrj3Z3kVFU5VODU8Hx4B6TZqQW9TOibsEyql1+ysnfNdu/1jAFTnpLGG8eUMy9Nz4fWUK6CuA/0POwxm9zIIxVSsgXuWmOGxK+JhJEPOz3x+Vo+66sXhr3EPbwkHCmPO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkE8RIrcD0ylHa/LsbFfALuOcH+e/UgJFuu4hA2uLhM=;
 b=EUMXIHuWVK79qgPKisRUFPYAG/o0PZF9/D1m0Tn2aAF5WU4U8gg4QQkrMYnWhqtPBBhoiTiVYvVzowMZPZJpqvIzIUo55UDhkyZKrD+6V8yBhlTEZHw3JDcqnkWag/i9Y8SuTX50jKJLSF1/iFfTxeuOhenKNKY8AOR5XROak/w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7543.namprd04.prod.outlook.com (2603:10b6:510:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 14:21:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 14:21:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: exclude relocation and page writeback
Thread-Topic: [PATCH] btrfs: zoned: exclude relocation and page writeback
Thread-Index: AQHXj4GI9FRDQitxX0OL8mIJT/tTOA==
Date:   Tue, 17 Aug 2021 14:21:51 +0000
Message-ID: <PH0PR04MB741690FBBB6A43279E9F1ED89BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
 <20210812142558.GI5047@suse.cz>
 <PH0PR04MB7416785CF79EF72CCDCF931E9BF99@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210812145017.GJ5047@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 150cd2fe-f03d-4b47-8352-08d9618a5b8d
x-ms-traffictypediagnostic: PH0PR04MB7543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7543CADA2C2607A6FAC8ACFF9BFE9@PH0PR04MB7543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNhPEQO48ooTQ/6qIOMY0DmWt1TY27LgnZUYe6BTFvfkyIKn2SFkqCboAdpabIaL0LqGf5ysEKjLwohwxTzvgD5l1McDqY5+Do0XFVne3HRx18cnZRPUrzMwmVq0xnAZJcD+k1tCB6mLgq6bTvDviPH9aTj+zNbIhFqmwQoFOXyMu1pEhoGQNAktrcjd5tLUoSTSxRy2Ca2iNr2AqtocPETpnc+8vxshyZW6+hswfW5r1dOPrGQtHlshjQHb5hvYHiVLNrOfLqaaIEtckDeqPUp30KUBlqDSPV8fa27L9v0Gl/uGGK6HETDRCxg1u7idQs8miSaZqJw5oQH2yIsBhxN30n3Jc7Tuk4SaxCbigGanF3W+rQ8QpT0WU7NVrK2vB8OU8/XzYBxSCtMJCULCWEUgLLtaKbxMkfm6YHJkmJWG4bYP8zY6Fq8SWljy27mQembDoC/Mu7p/XL1Smif6U/xMG81bAClaXCTOCeJVWFyybQGcqDeVq/I942hbabYHR5hHH69fPccOw2yoLTTH9a341Gy0WVYTvQf976pzY7X4dmIEXVWNXghEixRk3pJmjy7DryzxJXzrQw2aPsKBHuG0zr8hQhBQCHvz8z2DfXQLvMhezEOKSj9NTJDvnFx4SWbuVTmB2fYCxUqoMH2aYGIfR4WcCAE+O4MYBqKfESnXRSakK+Hur0IYOKdhW66HsWAzHS3Mo5BlXzYS/LqSiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(33656002)(55016002)(66946007)(38070700005)(316002)(5660300002)(122000001)(52536014)(508600001)(38100700002)(71200400001)(186003)(8936002)(86362001)(54906003)(76116006)(91956017)(8676002)(83380400001)(4326008)(64756008)(66556008)(66476007)(66446008)(2906002)(6916009)(7696005)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F9VxgNuMKxuCIDZ+ByAznoin53t9ty85heN3qvNbtBZMddQ2a5pj3tsjl/Hr?=
 =?us-ascii?Q?hINHNcCuOCrx8BZrpxjgg+V2UJA3nYpvwNPUFT6mHbHLpevAsbs3gK9Ux0K4?=
 =?us-ascii?Q?ByarWDOMj3ka/XkRjY1WcSJUM3qTLsNETvcq/U7D/ge7GmTEyYG55+FFk+GQ?=
 =?us-ascii?Q?1eSdAmBZ9m6AYrHWYAgucSZ4g/+tk6PKeioWwUk1yWMqw3cO5wU6QekXKZTc?=
 =?us-ascii?Q?7p/59jDbzy0RnUC10J1ucj6e2uQT56CSOo1r6OGwsiHPsFGmxALUIIsCn8SQ?=
 =?us-ascii?Q?srKXaAhcA+CLxYqJd1L4sGBxFxn0wwK5xwozvXgyXgBnrgoT4+L42tlkJEs1?=
 =?us-ascii?Q?G+vCp3yn2MPX0l7AbUo95hHK/QaKq5ikYnMUf2O+1ewDg8sHQHhaXscCHY0V?=
 =?us-ascii?Q?ZrOzmm+0f4U7pAlG1gqz4fSk1QuORVKBIwpJBBwYjjjmZUkbQsv8tvZOyjBo?=
 =?us-ascii?Q?j/u6pfJYURUN0qnDr3r9vVN0Edh2EaMWW3mY1bJK7GqeFdcZhaIWdb7p4Ear?=
 =?us-ascii?Q?Ij2c8nyqdQXqpVu8b4NbsPkdrAoEchHelAgpyts887K5P7dm8vtysibhYuBH?=
 =?us-ascii?Q?IBuFvk6QyRgkM00wemcKqWiX0yer//satd2vtLfCInG44OC2+3F9CzU1ukfr?=
 =?us-ascii?Q?HBKY0vK2xsjxe0Xey74CbyZlfTb2h3STPHEhY/IM4l/UZg/ey/uZGnFyPyaZ?=
 =?us-ascii?Q?SB6gYaXRxrT1KGLHTQfjYPkli695oCmO+oSfpEimpWHPFWn79nnGJOCD2cyd?=
 =?us-ascii?Q?GjdkR++Z7J93Gwou9WYv3Hal3LZQnjS8rN5OZlJhjxD6aoXqMAloUho4wU10?=
 =?us-ascii?Q?lqdFBh0norxkmMDYEXHEQfh0TtBkGpkYRrd0YeAwzkwYQAMfS+DocqeCxCXZ?=
 =?us-ascii?Q?oYYvT7iTG4JK+5un9rAYwniZbQxeubU0BCFoz2iQ7uU6ojNiGNyVpNdtk14R?=
 =?us-ascii?Q?Fcl485VOS2sqcESgvc4g8aFI7rTW2q9vcKGbS1q1LuZe8/1KonzGHZPXOrG9?=
 =?us-ascii?Q?E1zSEKON8BpOYZwu6rGnITErG62eJTiFsuqWqE3AMCO7qVRVFo2nb9ZpzhZW?=
 =?us-ascii?Q?oVhqXv/CgRg/XFQVg+M+dLR22AlD44aqqcaIfvKgYXHRdBE+axbwjfqfPnVW?=
 =?us-ascii?Q?GGqBFaC00ZLJKM3uVoo89l+HSPv1kdYv1kuQ8p5V3lhwrtOQbdERTDw3/KIl?=
 =?us-ascii?Q?6Hn8ZRca17nwMl3B2uU9UUUbDraqkT//DzX0KR+SDGJLIBiEh2B4wU4PW4fk?=
 =?us-ascii?Q?vN74W/WkVu+4Y4GJtOTPMVgjC2VWOzRcfyCOHZf1qzuHeCWeVHfaV0nAFIfQ?=
 =?us-ascii?Q?HLwfg4dnLcda+TzgoCMhtszIVj2OZK4ArAFhmta07CmOcDZ4mG4Dla/r6Ety?=
 =?us-ascii?Q?TMUCX8LWlAmBlTjCWIzEAe4SaqJeblsIBDNXD6VWqNNPAW/VJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150cd2fe-f03d-4b47-8352-08d9618a5b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 14:21:51.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lUXCxMKVzZI4hCJZE3lINEqGD9X5+s/ZGxdOFKevJkkxRi9hkUBEwy8IbYkV/0JKvswRfsO8tS9Jg0cWnTawKGKK3Bz1RxZt89GgQgXS+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7543
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/08/2021 16:53, David Sterba wrote:=0A=
> On Thu, Aug 12, 2021 at 02:40:59PM +0000, Johannes Thumshirn wrote:=0A=
>> On 12/08/2021 16:28, David Sterba wrote:=0A=
>>> That's a lot of new bytes for an inode, and just for zoned mode. Is=0A=
>>> there another way how to synchronize that? Like some inode state bit an=
d=0A=
>>> then waiting on it, using the generic wait queues and API like=0A=
>>> wait_var_event?=0A=
>>=0A=
>> I can look into that yes.=0A=
>>=0A=
>> Filipe originally suggested using the inode_lock() which would avoid the=
=0A=
>> new mutex as well. I went away from using the inode_lock() mainly for =
=0A=
>> documentation purposes but I can call btrfs_inode_lock() from =0A=
>> btrfs_zoned_relocation_io_lock() as well.=0A=
>>=0A=
>> I'll try implementing #1 and if that fails see if #2 is usable.=0A=
>>=0A=
>> The longer alternative that Naohiro and Damien also suggested is avoidin=
g=0A=
>> zone append on relocation and running a block group that is a target for=
 =0A=
>> relocation at QD=3D1 but that is way more intrusive and not a good candi=
date=0A=
>> for stable IMHO.=0A=
> =0A=
> The zoned mode still gets improved in each version so we might not limit=
=0A=
> ourselves by backportability of the fix. 5.12 is not updated anymore and=
=0A=
> that's the lowest version we care about regardind zoned mode.=0A=
> =0A=
> We could perhaps have first "heavy" solution like the mutex backported=0A=
> to 5.13/5.14 as that we'll probably use as testing base for some time.=0A=
> In the long term I'd rather have something that looks lighter, but I=0A=
> haven't analyzed the bug nor the solutions very closely so can't say=0A=
> which one is the best.=0A=
> =0A=
=0A=
JFYI:=0A=
=0A=
I did some testing with the inode lock and it looks good but does not =0A=
necessarily fix all possible problems, i.e. if a ordered extent is being=0A=
split due to whatever device limits (zone append, max sector size, etc),=0A=
the assumptions we have in relocation code aren't met again.=0A=
=0A=
So the heavy lifting solution with having a dedicated temporary relocation=
=0A=
block group (like the treelog block group we already have for zoned) and us=
ing=0A=
regular writes looks like the only solution taking care of all of these pro=
blems.=0A=
=0A=
That's what I'm working on right now.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
