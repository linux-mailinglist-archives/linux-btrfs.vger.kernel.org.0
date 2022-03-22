Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955D74E454A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiCVRmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiCVRmQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:42:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD68887A3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647970848; x=1679506848;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fjOuauFBDDDlRiHyCT0eQh2uocAtHRWwCyInKa4m9HA=;
  b=hPUpJJQm+lNzmUYHXzFS8PXhN993R+AZTnw4VvNns6PPVkiMBwkHERxF
   q6Dx57M0C+wnthkY6VZWF6SBIIvj5TOMRTBMhjfxh4tAslBmOkS9gngpQ
   1KHWVbqsxfEcZd/kaBQolkSluU/8mTdJO17T74dcdPA9YjV4Kudq3Sp2R
   LnxI3TWYSapWGP0DEU6+deHA3MFOzg+7grpaiaubYak8iGeSSYnrCUBZw
   zL1ZTTSw/FWirIuvkw1G4NbnQKvRnUy6/XYjTKrTUXBj9Xz09/yc15vWL
   FOKnmfrpHXUQfuyqmZ937CKNEymR22pGo0fb7RGCZGxQMj+Weq7jyg1bb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,202,1643644800"; 
   d="scan'208";a="300134245"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 01:40:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8IoOGIVThtmDXTQKRprTNNqCJCyM3pXeCTBLayNyPRIBOr+ZmadbbMeTMTYHURSfcdx54UJFMj92Qau6B5ZBr8TMGOTsFempfIhX+CnkaZ0VkYkl7E5TOPd53qMkkqNEOPgdZPu2gGopJHCjgXREx0ZZXHcU/yTOjWT46wOKH5SAE1lV0nO5ab8wEfy9enJfttCPwN476eIeawnPHJoKjvyiL6cYRejNDsjWphZIPLAMt4UL4k0DeO5PPELNtuGSV+b8BK2smshzRTmyBK06U2jxyhHLMSVXKwtgEgYgiCrHfGKDvrJCHnVj3Ve/2sta1VOJj/rQLMZKtMdcBGKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu4iXjQOpXlUuwZyn2dLhETCcyvK1o8Ys+g1egNLUmg=;
 b=m987Svpl9drzDSVexNFcIpnnc1v7I8MD6hyk8GjALs06F+CgKU4tHdQAu18NZ2LmFwFMhuAG7a+pD3Ty37qJra/LD1XWpyEiljDeHEqAK4+BHT5buH+2dmHMj+vbtMnhJLGzLWC9A5M6tPifs3gGNqty96ffbtMKMRRp+kCWCgkzORzFFV7UWJJCY8mg+xqsWTce2ZPIy6ts501EhsCR96RfuzmHyMyy93neCt1kci2+hOa4/qzImNNx4fKmTcAPH2CUqp2RdzE98V4CINEqLMSV19WIxQtzNSWLY3pA3kw8vT6GXQMFzv5YXdL6fEtv+IAYfdVEL0lrjf0xbqjHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu4iXjQOpXlUuwZyn2dLhETCcyvK1o8Ys+g1egNLUmg=;
 b=TDi3tgOBJZrLOM7sBSpEsMzspNCKMMx59SOi4WsuOmB6nt7ROpzGw8/vov4Yx4GGD7+0GHKjAakLw8F/JTbygw+5fCCWs0c00iFFneVnMo+WXZJNjh6BG3DCDEFb/bR5bvheUsOfz6obSdt3mKBaQbkLiD7pioOvrtlgfnZLNQU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB3853.namprd04.prod.outlook.com (2603:10b6:805:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 17:40:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:40:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/5] btrfs: allow block group background reclaim for
 !zoned fs'es
Thread-Topic: [PATCH 2/5] btrfs: allow block group background reclaim for
 !zoned fs'es
Thread-Index: AQHYPT7OC+fpxQgsTE2bQhWctTFKhQ==
Date:   Tue, 22 Mar 2022 17:40:45 +0000
Message-ID: <PH0PR04MB74163203C0988A3C4751BCC59B179@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <ef7463193e228bbb348bf8a8d587aa8b95bebf22.1647878642.git.johannes.thumshirn@wdc.com>
 <YjoJgS244Y9x6OPu@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 311f38b8-9e5d-4b1b-6914-08da0c2b186e
x-ms-traffictypediagnostic: SN6PR04MB3853:EE_
x-microsoft-antispam-prvs: <SN6PR04MB3853AB46E7F23459A0E9CE259B179@SN6PR04MB3853.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhoqTWSofppLTl03XBLsc7I8ylLoFJR99UmgkaVQSV1Y3ZmxbZGJjIRv01ROp6QJLw6RlyOKYZHxU+VVAHhUCNRCWxe40XfehERSogVp5sEtO0eK1YdGJ4haV9DcK8ZIG9DPg9EUMgPsFbbhmVb/Kxaj7zDW0sR9UIG7It5ko/ZsHKchS7C/vM5iOA4VrgvV088PSJiOfthy5rikgZm/nUMY9u67CPKG/wrCF5nLxZWnJBVliZhlHFjoEdVg4aZgzoq6fMAuPsrfm0hnufkxtYewHm1KxVViseWBd0sWOkd6gumnX9PgDSdDcmQUvVtH6c2Oj46CSK81cHHL3KPVqS60NEXO43Q7FR3WJ1J28dGrwETqmSJlGQGk0OitRWp5VQNPib89Z1dEq54I4fhDtWbkZtUagKoDDEbK83mk1gpNTIPvIrPBOhH9H1uMzbYxgWZcC2Wr3JtzP2X7aXB+gyjcY5HJtLAN3zZqcMj7LFr4Y15MKxSjA1NwMWeGwM1NFhp4PErf6fFmopyNb7ep2N8q51ZvsScNuxeNOfYfDZ7C+9ekM1DxDnxYyHiH0z3pU+4RX+rXRrYzMhq8mpb3hgnmibigKJZTdJ2js9wIWYfzWjW2zIB+WbA22ZkyBaPR3mKneoVRfj0VxkEuA3iYm9cXp91g5ra/463iXvIgy27zSyeda2JTmkkDOfrWIf1RR7GmoG9/RHpQX7zRNS5kLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(7696005)(66556008)(6506007)(4326008)(64756008)(8676002)(66446008)(6916009)(54906003)(26005)(71200400001)(186003)(508600001)(91956017)(33656002)(8936002)(66946007)(76116006)(5660300002)(66476007)(52536014)(83380400001)(55016003)(316002)(82960400001)(38100700002)(4744005)(9686003)(122000001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MnAsBLneD937Z6V1xoeqPyjFgmWygHXmvjR0wR70hcNsA8tUDRmzBXCZyLy4?=
 =?us-ascii?Q?wv7dcsYubaL4zZLvU57bHMTsq5h56sEUTendk0Uv3V3efXBHLLT9C2zXw6xG?=
 =?us-ascii?Q?CR57nizqew+btOItfPA3bxeoI/yL7nLhffS42Hgh6mhf7ywsY0SunktG7okN?=
 =?us-ascii?Q?mPkuTu99mFrATWQe0FrvMwLTGPhWevq7Rl93KHJq256iHbiWwOTOUHRkFN1R?=
 =?us-ascii?Q?NlRqYRR1maVprVbRcNFC6Q3mfC6ETespzzRCmFUQlSSyAiH06cRB7m6uXis4?=
 =?us-ascii?Q?VtLb0sbl8HT/U5MBfCncVvIXryYuhfw7rPQxB/rxsl9SI4P7MVK5jzLq4qSA?=
 =?us-ascii?Q?l4H5QkOXw3HqoPgK2/s9lGmNaW2StBXnOJUxWd3fXxLD0a3IMM6FRnIsjzzp?=
 =?us-ascii?Q?djk90f1+M7eDOZUuyit4XGhpkVjZ2pxPdEYGxpXdmcugcpZviKnfMA5zspgS?=
 =?us-ascii?Q?rYIKWE5LsYs4d1KgsuzcihM+bypCOCSRLxbhoapekMUtBFP5/0TDDYAdueNb?=
 =?us-ascii?Q?9pUcYZ9Hx87y1UEgWfrlRv8AEl29GNq3HHKTYEU8CW1nfxGq3Uf1m6eF6qI/?=
 =?us-ascii?Q?XzlfiUZJ6gbZbr9yRj8i8kyfPjEzBRsfUBg7iL807L76HOFiD5SBIr21/7v5?=
 =?us-ascii?Q?XzIf+ePBM79+jYHmUwovenAwvpgiORe4MPS3IDhbozUvR+STi54J9Je2pOKi?=
 =?us-ascii?Q?4kpNT9RplETmPkoW84r7m5CY9xk7dvzGQvGpt2/2ZIpxs86FlO7PrdDm4eBO?=
 =?us-ascii?Q?ro8oqO/nVukg5c8Pt2jhURhohKG8Hzc1PPaGNTYHHSpaxaH++ZQqLOfct27X?=
 =?us-ascii?Q?hUC+lpLDQuhsDItoVgVMIGIoic9+jxteOvx9ywcQLt9YV1mVGrdPGKGXUrtV?=
 =?us-ascii?Q?HhPsBUeag2zpW0lBFMLh9PbSKD8XyA18e1cgjYCRSr+uRL/fHZWkK1NFjgzJ?=
 =?us-ascii?Q?+H8q8wbNW+TLgZnyw8XDP+Jk6C6m9lyu48DThUlta8TQfUPcddM9J2TVRYPz?=
 =?us-ascii?Q?J1arGBBRy3ze9EnmumU4u9DsdxWRR5B08SuOTgplWfIgTFCLTEu8BKGnnOkG?=
 =?us-ascii?Q?Wg9zofaHBFdMQYcxDYvJG4Vw8nqTe/pwxRWzkz5o8N5yYzgLixYaWZW6m/lZ?=
 =?us-ascii?Q?6W2PfxK3JzSDyrUEN1ffjmrNYyCVbXEvJNXvHOlWGdtn9+fsh/f4Xk/vOW08?=
 =?us-ascii?Q?d7pEPDysiclwiYNxVrjsczSAaKRR37uUyRpdjNdk3Txe1yyNyJjGFFAoM69V?=
 =?us-ascii?Q?RNtjSwbIcSCBkjOxLTFcrHgPrrG1IsAUDU79YUtW0ZFDesJPPTKMxiAeJEkA?=
 =?us-ascii?Q?Vu3ZBWloF417uddvpXJOuyZuQwxPzfIF0abAqW7vcLm+ZZLSuvi8jeWPc7DW?=
 =?us-ascii?Q?HqmyYEYXx4EAIWVb210LI2CtV/tx3mRCjmyEW2HHFyCTZS1x3DTJJgl3w6Zb?=
 =?us-ascii?Q?11Z7v9hnR1FEqJ0D8LDHApLaLf/+MVcQKdutjEZndw8h+GsQr03m912mjmaO?=
 =?us-ascii?Q?Bkqims0XkJIriWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f38b8-9e5d-4b1b-6914-08da0c2b186e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 17:40:45.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLzJEygIDHuiwaPRexMjN3oGHAnBdTC0TifdJv9V28gkeUVt0fmleB/5OkD2mLJA8hXJMvPkugzsLiD7L/t93QVyA2d9R3mLIfdv2XODPV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3853
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 18:38, Josef Bacik wrote:=0A=
>> +static inline bool should_reclaim_block_group(struct btrfs_block_group =
*block_group,=0A=
>> +					      u64 bytes_freed)=0A=
>> +{=0A=
>> +	const struct btrfs_space_info *space_info =3D block_group->space_info;=
=0A=
>> +	const int reclaim_thresh =3D READ_ONCE(space_info->bg_reclaim_threshol=
d);=0A=
>> +	const u64 new_val =3D block_group->used;=0A=
>> +	const u64 old_val =3D new_val + bytes_freed;=0A=
>> +	u64 thresh;=0A=
>> +=0A=
> =0A=
> Actually do we want to do a=0A=
> =0A=
> if (btrfs_zoned())=0A=
> 	return false;=0A=
> =0A=
> here and leave the auto reclaim zoned behavior the way it is?  Or do you =
want to=0A=
> delete your stuff and rely on this as the way that we setup zoned block g=
roups=0A=
> for relocation?  If we use this then you could make the=0A=
> fs_info->bg_reclaim_threshold also apply here.  Thanks,=0A=
> =0A=
>=0A=
=0A=
I actually like the per-space info knob for the individual block groups and=
 then=0A=
the global one to kick in reclaim.=0A=
