Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30703573846
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiGMOCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiGMOBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 10:01:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA62F3AE
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657720894; x=1689256894;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8IrVdZ+Rx/VsJBwubGOlWfNIlorpJxEycw1PX5D5SX4=;
  b=jXgZ08iXTeA7MRE1fMrP3sX56v6JyCEIcn2OWdIRHoRm/lNut9Df1Gqk
   YQJ36Zq2XOn8BeBz2IX7Sy528D+LM8CW1q4LGfVrrKImN7xT/AVncL4G1
   Uq+Lg71FyifEQpn12GWSPf2LZHr3x1TOyy7+EpFST+QhJcLtvYauuKZ4M
   TuNEYSnrAHOFJl81KnWW5NT7iuQTsiD7pH4iVkAhTrJVFLKRpmg1libzN
   tkr7+d0klHGFMiAH1lcy35dzHommMwgU3H6I18yxJu4soOnr+K4wt7kB7
   TeLqZug3u9dER78EVoBnn9qxyzfZABvothXyB1WU/DzGsJinh0e5oilRG
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="210554087"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 22:01:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8H3TFBDcuu9GOtb/sqFLxsM1RJeaJtfjfWyUeeXQnQGVRF1CPxtjzpdp/Z2y3WJ9VwE5O6JFajdyiZBXVReruSDUpLFAwyWP4zWIlU2sY9haJBuoqPOeYYBiIVWrkhNEqsTPX2s0O03XEN0mtJNowmIWMP2up0iCtg26jQvebS4YT98YGKfkupKvrMf5PNx6s4h1e1L7mb/2UZ80zgeCgKhfvHeMiSG6H/k9CfoVSULJ1E9Aq6IPnjcP+/v9ObyvZmLUrUmQF77M+AG2T9OVodQZMC4VX3WeBfWqxUK9pCE2JrCCUQKvTIP+0d7XJPDoouLFxg994Gl8uTUFF9d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GjejJk5e0JGp5kgGvaP/hX+szN8EUTnHQIMmFUfpLY=;
 b=DNRmMjMv+cd7n/hwYk6jj0T57meEXVWEx3XBCNsS/KwoLKAlw5GPDIRBnuCZuwgi8DFfQS/oTLeBJGqoGRgZQOXaGOCCGK+d294yLscO31SE6qqfERWhrd9kFEotyHYszC56aQqNyElKEN6RbDDQlNlpQVbr4ZA2jf/vtz0C2f+bSkJmfbjRsI+B12P1JwrYR9O+1Xj6qQTxRw8yLlRYNn0v+januuMdMQEQArep6mwT1w6BP7O7eXgGH4jd7VWLbstZnj64ghtBJL+eztdNoqTZvb8xu/rew9xSGLWDuqY4bg/DlbhI1drUB3DuQWb+P1SQ9nRnP2mtM2ecxFOH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GjejJk5e0JGp5kgGvaP/hX+szN8EUTnHQIMmFUfpLY=;
 b=Q3VQ2qzHldzfyWaH79CVF0wFZnr5Oq3U5USp4qJc8LNX/rLjIfc3inF8gvkQskp7sp9qounNqPoE3JFpws5UaCT2GUEUT5sSDxUHp2uSsYUTR9MjlFb+yRDiWFKHyIF6l6AyXi4Gh2DYPGdYod7S4mHTMxy2ndqiiwBqLQtAF4o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0611.namprd04.prod.outlook.com (2603:10b6:404:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 14:01:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 14:01:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Wed, 13 Jul 2022 14:01:32 +0000
Message-ID: <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4db6c00-7db2-48af-8255-08da64d83121
x-ms-traffictypediagnostic: BN6PR04MB0611:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjmcCw9IbCTvTQnhEC9OYqECI9uTupZq72rlUP02hFA9gY82bLMD9BaurcDSOaVHop1ezW501x73jztY3Bi+JGOHdGFv0eEkOm43MmhJ39UDyHVeFSh0L7YW8EihO/MG37zyISOcnKwCJMVqGYpR0seC2OV1uPq224TD4d66Va0HExHE7FXoefQvm82sawtkC+msXAtCgXLRRau/Uu9hcDHATDu6SNs70BGxzULcAaFredWrc/6C1gE8uDtN5nVYQttTMmMCqs7ED0rsiXNf4Pc4J7BsO0WXHKox7SskGc23UL681USiSbU5BNmfQP8n0ZsQiAPlOmWv2A7tm48+4WohibUrrnSQp9PPlcBXfCClVZVjiCmK9jGyJYHqRBMq4R/iDxZeSCPIDsNZ/TF+dWoTmxbBF33bieCbGfkPgRcyLteStpOVt3w1K4jE9UaMqMS8a9s9WJJTXdOXyXEsx17QeruzE6rAXn9fSJD2dRRACvGSCDl1NdJPh8sLEzDTEY3ejfrkFJBTwk0a4rlXyC4wPVS4SgcjTGNLlDKuDqlIrFm2szaE9P5qPb098jYGZP7pj5MN/P5L185CwJAckkuxFXbKejsIkRJX9TapPq6wkuNxqdmQFn6CqrQzEo1oMhn7IgSwlL9AKee6E8zLGPhtt+ZFEOnraaA3BL+YZr61sn4qtVECB1KyO2B9iT8XuRpbbg20tK6de92RBCvi1CyA0unBTqd+AfNVm2CubcFCc2sfdMCQuaizZ+jNMlBzd3x+aq5VbRZSdTJzNyvrVMqIqetZABSCs+j4bkncDcDFI3ew7mT2Hh4DtVmkP7Zu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(6506007)(478600001)(7696005)(53546011)(9686003)(66446008)(71200400001)(41300700001)(91956017)(66946007)(66556008)(66476007)(8676002)(64756008)(86362001)(110136005)(76116006)(316002)(83380400001)(122000001)(38100700002)(186003)(82960400001)(38070700005)(8936002)(52536014)(33656002)(5660300002)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B0CD43XVu98yTJUbV2Sudxzl8hn2wLGOmiP3SNy4UgpRnQxLuIY5M1mtel8x?=
 =?us-ascii?Q?v1uOlpjs4OC+NGiYUZKYuFi/w+KcT639A4rvGGZyvkB2LfHsVwCJTH83sDm/?=
 =?us-ascii?Q?5Kdlhri17lme0/uLWEWSh5j166VxdrOcWzRVVXvjLRMzcAzBTmuPNUozfCnS?=
 =?us-ascii?Q?yCajx46RfM3R8NWwynrVCepfNW2ASbePWSYlIDGYtAw5k2LVug4RoWPvo/GB?=
 =?us-ascii?Q?r6oGWQk6VbBwDmhkHxA//XLH3aJwweDDHKvhaJdCoIA1PCl0MI3PCK3J0TPh?=
 =?us-ascii?Q?62/X24oyuVBpOvCcb6s4sFWG7DTo+l5N3LIqbqk+qjOppgAlrja6dPffUQbu?=
 =?us-ascii?Q?vcY/DkXsX+88NwQKsXbSCYEzG4S7CF3PtNKhu6vSnB+sBycoF44lda/kXhUh?=
 =?us-ascii?Q?y9gQPcOu80si6pbN53KvU9pKlXTXvbSIrlMeH3Ka/gTxoLnmHx8pyaIfTuZt?=
 =?us-ascii?Q?WuZv2aKfmh9I9v4JzEz/ukoY/eK+JHXNSXcBWbcgq73JlmZZh7y8uazWP6O8?=
 =?us-ascii?Q?BPYbLwEBDn2pWKblP5IwKhNUJHFS23u9WOaMomoHl+SaHryJcHO0hEKztoeD?=
 =?us-ascii?Q?6+0fWH3u9l2nRCy+HW0IMySm6bXpYp9FxZaeUzxIxxHKmsprFI2OmMHxFFYH?=
 =?us-ascii?Q?kaFB4UdXRd9+gY2nABkj4OzDBi5ciClRpcZBMsq6YCAOpNSaOtlSwHbJdXEf?=
 =?us-ascii?Q?wV66v8ovJiyGkT9MHtbSrqAVc8T9d/3scs20i8i0r91LrkmugEHg+v38JbVS?=
 =?us-ascii?Q?Cdfb3yYHo/wHLAZQkZMtj/pJo6VpGspVMN4pcgwGcRY2lj5NVUdtJidsy2Li?=
 =?us-ascii?Q?CrcqM/NtBV0g+g4Nz4eDksww36mhtCwO3GAptHHj29Q50nWSxD+Fe4ib5Cj5?=
 =?us-ascii?Q?IGkp6/2UitD+2xgN2pNfzN19LFavUwIeg4QfPNBBTHnjngQbmR5I/gPxccw0?=
 =?us-ascii?Q?15Wq1fB0L/SGRwOYuOqM/QROQs1hBbquB+c8JYWIRFoFS8Kxo3NuR9rqm9LQ?=
 =?us-ascii?Q?SmsFVNqvhzOfh/LZlh2h32jA3VVvwsDrc3Z5b72oR/KWStdtIkg1HB5Y2ZM+?=
 =?us-ascii?Q?FEdix9VvUvYpZq+uwh5wo0jrm9TokScancvwIklbaWC0zImeS0QkTHxABcBu?=
 =?us-ascii?Q?Ks1yZ+r+fltuhOybNX6OmY60eCp9tKdNcqvLOOuw+pzqR5ZmUbulsS3GF0b1?=
 =?us-ascii?Q?HIZfo35/3qXr9sr16S4cuwQk2uzOsbi9VCZCsf6rNKLFnFSo/TJ0FcF2nIct?=
 =?us-ascii?Q?0FCkOMcjMYgOwfpUsj004D86nxeSECLiNg+sksusnsDM4sh5WCYL1jqDakgT?=
 =?us-ascii?Q?K2kwVRKAbF7WndLPs8unhgPj1NLe6ok3DDRgiguSAFkvh6xGuwuvbCzVbNaO?=
 =?us-ascii?Q?KHYvYC+pZbifbPG0252WntQ1sLEt17NHgpAHPT5z1Wnp6dxFRkTOwO6hjR2I?=
 =?us-ascii?Q?0NHvkD+zaZBN2lNGedd7R6I3bekUCqDHmOmDbWVHNbvEnOIEmYTpKYaK4XIq?=
 =?us-ascii?Q?5MevLfGzSzCOhqbUbXh5D1E7d3anOn1XApc6k1Ma5TiDuIVfv5vEQcgBevzX?=
 =?us-ascii?Q?zrUbdHVVjUU77ixDgqh+MkxJ5Hh7g313y5HkrUaHUlxgtnc1iXQ4Ljza2WFs?=
 =?us-ascii?Q?m9voXky6kkbHX8eJJd8YSGe66ZdVWCGvvETmVABxv0TJcBDoKzKQrEx1KKSx?=
 =?us-ascii?Q?8tY+KUfKZmU1ho87K3n0fRF6liE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4db6c00-7db2-48af-8255-08da64d83121
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 14:01:32.5714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GI4bmHZ6hBfdjxz81Qx+05FQcXAMtKCQwlZdq8vGPjXX/q2ltS8FuoND9FM8/+4GYdPdV6u+XfkLCAyVulffwgwSL8tPOjGk6CPyZnHy4zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0611
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 15:47, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/7/13 20:42, Johannes Thumshirn wrote:=0A=
>> On 13.07.22 14:01, Qu Wenruo wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 2022/7/13 19:43, Johannes Thumshirn wrote:=0A=
>>>> On 13.07.22 12:54, Qu Wenruo wrote:=0A=
>>>>>=0A=
>>>>>=0A=
>>>>> On 2022/5/16 22:31, Johannes Thumshirn wrote:=0A=
>>>>>> Introduce a raid-stripe-tree to record writes in a RAID environment.=
=0A=
>>>>>>=0A=
>>>>>> In essence this adds another address translation layer between the l=
ogical=0A=
>>>>>> and the physical addresses in btrfs and is designed to close two gap=
s. The=0A=
>>>>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and=
 the=0A=
>>>>>> second one is the inability of doing RAID with zoned block devices d=
ue to the=0A=
>>>>>> constraints we have with REQ_OP_ZONE_APPEND writes.=0A=
>>>>>=0A=
>>>>> Here I want to discuss about something related to RAID56 and RST.=0A=
>>>>>=0A=
>>>>> One of my long existing concern is, P/Q stripes have a higher update=
=0A=
>>>>> frequency, thus with certain transaction commit/data writeback timing=
,=0A=
>>>>> wouldn't it cause the device storing P/Q stripes go out of space befo=
re=0A=
>>>>> the data stripe devices?=0A=
>>>>=0A=
>>>> P/Q stripes on a dedicated drive would be RAID4, which we don't have.=
=0A=
>>>=0A=
>>> I'm just using one block group as an example.=0A=
>>>=0A=
>>> Sure, the next bg can definitely go somewhere else.=0A=
>>>=0A=
>>> But inside one bg, we are still using one zone for the bg, right?=0A=
>>=0A=
>> Ok maybe I'm not understanding the code in volumes.c correctly, but=0A=
>> doesn't __btrfs_map_block() calculate a rotation per stripe-set?=0A=
>>=0A=
>> I'm looking at this code:=0A=
>>=0A=
>> 	/* Build raid_map */=0A=
>> 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&=0A=
>> 	    (need_full_stripe(op) || mirror_num > 1)) {=0A=
>> 		u64 tmp;=0A=
>> 		unsigned rot;=0A=
>>=0A=
>> 		/* Work out the disk rotation on this stripe-set */=0A=
>> 		div_u64_rem(stripe_nr, num_stripes, &rot);=0A=
>>=0A=
>> 		/* Fill in the logical address of each stripe */=0A=
>> 		tmp =3D stripe_nr * data_stripes;=0A=
>> 		for (i =3D 0; i < data_stripes; i++)=0A=
>> 			bioc->raid_map[(i + rot) % num_stripes] =3D=0A=
>> 				em->start + (tmp + i) * map->stripe_len;=0A=
>>=0A=
>> 		bioc->raid_map[(i + rot) % map->num_stripes] =3D RAID5_P_STRIPE;=0A=
>> 		if (map->type & BTRFS_BLOCK_GROUP_RAID6)=0A=
>> 			bioc->raid_map[(i + rot + 1) % num_stripes] =3D=0A=
>> 				RAID6_Q_STRIPE;=0A=
>>=0A=
>> 		sort_parity_stripes(bioc, num_stripes);=0A=
>> 	}=0A=
> =0A=
> That's per full-stripe. AKA, the rotation only kicks in after a full stri=
pe.=0A=
> =0A=
> In my example, we're inside one full stripe, no rotation, until next=0A=
> full stripe.=0A=
> =0A=
=0A=
=0A=
Ah ok, my apologies. For sub-stripe size writes My idea was to 0-pad up to =
 =0A=
stripe size. Then we can do full CoW of stripes. If we have an older genera=
tion=0A=
of a stripe, we can just override it on regular btrfs. On zoned btrfs this=
=0A=
just accounts for more zone_unusable bytes and waits for the GC to kick in.=
=0A=
=0A=
