Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1FF5083A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376823AbiDTIoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376792AbiDTIoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:44:02 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB931502
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650444076; x=1681980076;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G3R3jo5UkTe6oaixpV0erYWYef85AjOeFxTN/xad5jE=;
  b=J41BUc/VZAIdB0WMwEt9tK7pfrQdJWqSjWHD1820D/IzoMqOpJXADy+V
   7VWU81mHt4nfoM5pQOmHANetQBebL4zD60tgVG8QERGDYvyuFiu1M6QZ9
   tOdDY4sly4w9FnjJkZ9BcKlzuh9OChQF7OUMDxhO9sZ6QK2PcU6bx125L
   revqUWrM4mRRCACYIW0orv50w3tZVA71nbbuvrgfOQccymUXv95/eXXmi
   XzprWG4Xfc2UKwHQTHMwDrZ/rOsAcKH2EtVO/Jh6NoFC8BqUEk1lNCkpx
   PYeGE+O930N2i0iWOmWozEdXFScHJy2fXVWPwfQZS44vfe/i8SUoB5M57
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="302542548"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 16:41:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJsRRecP0GF/NwnrsqrxSUaQZI+6ZAQTVQpZsbjhtTxrs/DlBJMovzXV0k6tdvxL7c59Nl/jPsnEn1Ma7OwzayyBqN0Ywi8t+XEeRg78H/20VnmhWtL3jS5JgrExEkgTzZxiOsA4VRkQtugtlliBOAaW0u6ED9hfFmc/FmVJbq4/F1kNg2hqhbNxQkwYg3xI70YhWbAf0vUNSqWw6U67j5RJ+2bNTUD/7HPUg8bpTUDsr+aom4sZOetw9kAWw5uwo3hKR3naq+eGdp7N1kedmOzIZPmYgEaxoHwDJnmPFyVWhjkC4GNhb6IE3oOTiIlHwWPwgUuylosdg6p05nMU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVJH86d/Hbdkf8phy1mp3lfP7zFS7UJGWwWRJmsT84M=;
 b=C0jkVOzZ7tYw++4hqnPf8hIiyHIwpnvARlx/K7RpEWhCtNpKaQrVlZN+w/2wdu/PkqXsdnYWy7fVETjhHXblizFItD67jiV3Gg7oNIJHaS9TsNq9I5eMw3okKi66BlYuyhJDyUPlyZWQyFyeNrDMQMwfs+k9uIIw0ms+HU5JAIGcNOqqBfxSuscY1kkDbGdByvvsNyJGnfk+ioVzEGiyPGCUkiSlM/IwdOA+uiPs+IVQ5aQHjwxyhkdrSF0El2x5s3wvHOxXOV5Z6A5ik1MA0d9WxUK8tTtCeq+w2F+Tfmhigw1pXbtUJVUoqwPO78vnidiuAL+IjWHf4KXVRUJz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVJH86d/Hbdkf8phy1mp3lfP7zFS7UJGWwWRJmsT84M=;
 b=hx9sd2BqZXOJgBTQbgtfthN2U19/s1DN6ymioSPTB0FXiluoSxznwDifcmscyB/2KGXepOiFzPlEKhAnx5Bozn15KWMGEByTJ9CwbaHoSueuivxMZrNWEuvUyxzUVoYX8AdDgWCyu8EXy3IlB0DjqOo5IEOj5V8hI8gf4AHr4xQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4874.namprd04.prod.outlook.com (2603:10b6:5:18::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:41:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 08:41:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Thread-Topic: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Thread-Index: AQHYVI3mBuv3zVdth0in1hAYTZXm4Q==
Date:   Wed, 20 Apr 2022 08:41:13 +0000
Message-ID: <PH0PR04MB741682A87F86554F81F5AE839BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1650441750.git.wqu@suse.com>
 <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
 <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e57d9b3e-94fc-a20f-ff92-ccf19c0b035b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc8c8760-9ab3-442d-8b2f-08da22a9871a
x-ms-traffictypediagnostic: DM6PR04MB4874:EE_
x-microsoft-antispam-prvs: <DM6PR04MB4874174469FAF362C648238B9BF59@DM6PR04MB4874.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXvmAueZilDUW8kXwH1Q9CX0V7r9MnUVV6O4udDc6KTQNjfwInLKLM58J8wBUVk1f89uZ+xXpw/JZ3dLFSoXzLnzBKauk1FX8mFX3ZptZww936x1isptypPY93VJG7mfObwvdvzBv1Q8oUwG2IRM/V89EmOUmbJz9HB+kFUvYCeXQZYMh5x0/0MY5vzC56cx0q/f78NesYzG+ydm1m9f8r6YcHC9m89RZvPmXqjHbCG5KtHdcvnsB+nbLzHoazpdIX9fUf38Qtz8sJzLWsfQil9zSdu/sBthzHcNGN8ujlO1lwtXZKOlDuOjg1D+qnlvZLR8B7parHIK5HvXGvrpXKmDwOG8vAr2gQr4qaf39hdAmW1gsmN5LU9hALTukmilBDXriY71JyOZPvPznsk7vEPD8mXwvh4nHajZLRmnclB4vi6a6RS0YFnGSagyrrCru9/a6ioPKa/N7FmDvyLW8fw107zlYVLI1RWQrDR1hMa3V9TCdzchENeHNBDJWMJsGcTe0Fp5mRgB4SMbUBq0r89Z5D6mE1JRgfQHGqqVpc6xGAmXXkY+kK1PdriSF6IjkpfPBe58QpaNAs79BGyK1sFDSCi4b1QY4wgqonjItpOF2c1nY9pKcy5a1SoQDkjR9mpms5aIATi4AwlqLLL7WrwIVscnryvV9l1LsF/TB5OqVkjKJej0xS5F15r8+U7Qx5mJ5pWkmtJ1IULHR875Rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(71200400001)(83380400001)(38100700002)(508600001)(86362001)(316002)(33656002)(5660300002)(122000001)(82960400001)(9686003)(66476007)(66446008)(66556008)(66946007)(6506007)(52536014)(76116006)(91956017)(53546011)(38070700005)(64756008)(8676002)(55016003)(186003)(110136005)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHTqA2tIyOmZAxTkm4HIdQoEAenUHlpY0/puvjBniTCQLIZkadWlvXqtC7iU?=
 =?us-ascii?Q?IBGz+ifQJzAe+QWdVCvCBsVFD4M62RN70b31DxVCDN3+jghlioxtiqntfKPI?=
 =?us-ascii?Q?hZiKAYJMl2jLhJ1PRotIG8XfeoZ2eOmmOZYFOyAFWmu3yXBY2awm8ek3wdg0?=
 =?us-ascii?Q?gbNv38RQMIqrrGrGBfLDC+q8Mzy3DQlQWEWOz6xQqxuAyCljp767a7xNYyYm?=
 =?us-ascii?Q?W9CfMRvmzZ6MWq1wltg8aTlughaGoRPA8BxwRsdrXvRZ2mB5Y2i8Vbvw6ANC?=
 =?us-ascii?Q?lnZpcQdxT5xM9/WHfAAxR9D3P83iYgbcLsqxkDBWmnYZYPTBGMei7ClDylr0?=
 =?us-ascii?Q?5e15kWaoQHYleuu0uwtoXQqhuQhsbUBP8ICKRpt1ujkDOBuM4Sqw2Oh4JN47?=
 =?us-ascii?Q?pCMfKyvdKIPNpja37HWvQpVIBRe4+mAtnAIre1pm61lerWTMtV4zSksjhM0C?=
 =?us-ascii?Q?REoFZIs9ZWfe6b74mIEXmWWoJFEC86niP2+acVoYx2DF2IH2nnx7yRjiNb2/?=
 =?us-ascii?Q?7ihGdKNC8XeckaMORfJDCsHner1seqPGS/U4BT3Rd7z0VU36gd1etZq0eZYh?=
 =?us-ascii?Q?C8EOIVFrS9bzkOg00hcP2TpuHpV6KU38b4UTVrDIwdIqQmT1ku8FqHPMOkE1?=
 =?us-ascii?Q?D5QHLPI8eGwcALQy+8MBiEEeSkcCMVILjJ7yePh3Uljm6amxBCMKNTW3T/Nq?=
 =?us-ascii?Q?iEMFiKsM0+5q5av2p3ARKg4L9iLwqSwt500ybpzCfZyAQ/7nVl3ECQIbWY7c?=
 =?us-ascii?Q?j/TnHRcP29UngFbq9JKkKbp8YHhnHJwgwZVqz679oOGL1ls7GVto/tV1mqK7?=
 =?us-ascii?Q?ZE894d6yYPL5hgP40GDRW+AMk+d9JffNusom6DGG7jbuIqtyIn6s0cjfFz6o?=
 =?us-ascii?Q?FryLdAHFEvOGk3qcvNsRlcVw/2XRBuQPowHk/coEsV5h4JqyxZ8RjLJGMmOz?=
 =?us-ascii?Q?tCPdkurlNdis0UeDLLNnVYVJxnP1oa2MyJ6S4SPA6qgTTIXDXXZPm8DNGTWp?=
 =?us-ascii?Q?09lx2Pt92GWHobJ8oxjGE/57NoIP25EKA7L/69CYrMQ6sovPs1o2UNImJvQx?=
 =?us-ascii?Q?X66MYAnq0j+iS8Yrc/gQHnuiPJTwdEso1PSW0ETlM1BuLJ7KBEpVfLZUwsrW?=
 =?us-ascii?Q?mG+YT246IrWd3eBFPgzA+S0SSTAYmnNnayvFPEbHqLYPha/lHX5Uq+chO2Um?=
 =?us-ascii?Q?p/IHonEmqnAJmZnBgqUUdW1VCJXOeyFd0MGHj7dJYZhV8KqhqlMlX3z9lPCk?=
 =?us-ascii?Q?+C9nA8qpuAo3lO8zmXdm6tu7F5OTITUHdCp6vc1USvA1Y01iQVTftPQ207+2?=
 =?us-ascii?Q?7yhnIaIycMYzJWn18mmKaF3wSPL/XZ8DqglTPx7eEnIm+vwHM0pr9oPtGDcy?=
 =?us-ascii?Q?qLPfL4cDTmTqXiNd0/lt/sV257QOq9jy1b4h7OQqLmlTuM8OVXbom4VQCap5?=
 =?us-ascii?Q?DYLBIu1O5fGkyUYRR99fPnth8cgr0ZoFTPJQ7seN4IQp9NsLPTreyS5mfli1?=
 =?us-ascii?Q?hAGRSX26pXirUMNf4dIxjgkdfabBFlp85gA9fNTTPggkavhT4iQrCzouVZ7X?=
 =?us-ascii?Q?veXCvwaSHYk4RLdbAGJdpLFRXy1oWzPE9K4ymPfsrxcZBFRuPIzYXzvg4q1U?=
 =?us-ascii?Q?zb/zC5HnYEDUZ8absIxC/XhQOq7T3le3W1KPbTSduIijKoa/sx3K0UD2Ftrc?=
 =?us-ascii?Q?qFbwcjXDQouJKKpb2awFjB5hLTyhNfJY2hFlHan93GhabTJnErjVeTlew6OJ?=
 =?us-ascii?Q?NyHli14E8LcHO/V15y/LsX0SSI1BHa53n4NKxTqIOakaP4D4WcS+1Q7a0RNF?=
x-ms-exchange-antispam-messagedata-1: 1I+BnO9GFXwkuBrTs+kcWkUpMVj+eogu34eivau3r3PzKpm9zvVLfeG8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8c8760-9ab3-442d-8b2f-08da22a9871a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:41:13.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKwPiwFrQsSXSGlctYW1jHte64pkwfpIUnQoKiCL91zJ2ZmOd+gwO0Ni1dz27zJ5SAcEIa0FymFDy91nnUR9T9mO8QWWsU5kLp6b70NjbYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4874
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/04/2022 10:38, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/4/20 16:25, Johannes Thumshirn wrote:=0A=
>> On 20/04/2022 10:09, Qu Wenruo wrote:=0A=
>>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to=
=0A=
>>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.=0A=
>>>=0A=
>>> But the truth is, there is really no such need for so many branches at=
=0A=
>>> all.=0A=
>>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside=
=0A=
>>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate=
=0A=
>>> their values.=0A=
>>>=0A=
>>> This calculation has an anchor point, the lowest PROFILE bit, which is=
=0A=
>>> RAID0.=0A=
>>>=0A=
>>> Even it's fixed on-disk format and should never change, here I added=0A=
>>> extra compile time checks to make it super safe:=0A=
>>>=0A=
>>> 1. Make sure RAID0 is always the lowest bit in PROFILE_MASK=0A=
>>>     This is done by finding the first (least significant) bit set of=0A=
>>>     RAID0 and PROFILE_MASK & ~RAID0.=0A=
>>>=0A=
>>> 2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK=0A=
>>=0A=
>> TBH I think this change obscures the code more than it improves it.=0A=
>>=0A=
> Right, that kinda makes sense.=0A=
> =0A=
> Will update the patchset to remove that line if needed.=0A=
=0A=
I think the whole patch makes the code harder to follow. As of now you can=
=0A=
just look it up, now you have to look how the calculation is done etc.=0A=
=0A=
If you want to get rid of the branches (which I still don't see a reason fo=
r)=0A=
have you considered creating a lookup table?=0A=
=0A=
