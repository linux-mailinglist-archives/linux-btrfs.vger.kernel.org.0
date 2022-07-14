Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3929E574F42
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiGNNfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiGNNfX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 09:35:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E534E62F
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657805722; x=1689341722;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jPdcM6UMWIQaNgO6XAy8Z6++Ii5KCDE4X0LfbRExPz0=;
  b=TKeCtABsFo/8YMuMatEwCJM7RcTtGUpdtl2ZQ2/G3KuxSBJM1D4fX8nV
   FojoAxR0MPyVsmVTmBs71do53EW0j0CG//CTJwa4FQZ/yeTUmIOtQSMq+
   FMfT3A++UHH10PA1qQ3hGXN5XqIyPgjhA6+lcb96vCJKAXO4geul9GVJB
   dfparo8YCm4Ifeyq8t6FMU1nIciybcD6+YQ/JmA3hs+WUWcoglEgkbsD5
   CrXO/0tIwhOghX0TcGl1+/LwgSDJ3EbunLvg+iz447DBpdAXFKSRYVNsF
   4Q/LhRIzHxVsAPJoYbIxmqsBu8n3C9R2alDQRYtQxCv3vniue5kiVMakL
   w==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650902400"; 
   d="scan'208";a="206419801"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 21:35:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGORIw2r/ugTWXFUISqr0TT+6dBW7JmTJYntsILAQHkh290DTyqQUihNegEAudOS1neRXcEuQoIUqJzN5nSiqux5rEBkjVvrts1yF0pq39sMDjOospFTk3uVloBlZoHF+coCkCw+h1JiUJBNYmwg486if2fh3sDrOrYHrhAOz/UZxLfDbRoNm/her9rLtjQ390wzBbXN4l68c1VO0yQfXRbfE0yWrPWXNFgLm/weYKpcVigJx0Bs+CWVxxMwoSb8MUcleEdCo+EZuFY/natE4if9BlwdK+tx5RbSjhtU0UifEUnVtID8h2QEvGee+MMC68oCav4i2ZKYZxZIr1um7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMkRXEdbL57KoASOTTv+It+5vyBlwPZEyqQaJPvbZ54=;
 b=j/aoKUCRGtaaHcjodZhaz+OwCKcLOfrdQJErsUT1c+EQN9IVVM7VZyHAcqAdHdacTsoNudjR20biNdomXTecjYa570iAoE4JjczKWqbtfVflFL6huv911IrZ12ZmuAIb6tgztrK7Fps0rQPvMQEhxXcTghF1XgspcrIIOGDN6eL5ONlwAWUYVxxnfFDXuNWJLBTmVhZwdCuYFwCoxmA3mX7xs6yuWOadBczU5vtPDExilXNFAvmARQgndtoesYe2BR2PaiEnbdvdGqQwsBjJF7lySSVNPP7CoFyN4TN/UQBcwEe8CMD8MAwZyk14qO2Co5OL596akImurRPLqBh7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMkRXEdbL57KoASOTTv+It+5vyBlwPZEyqQaJPvbZ54=;
 b=RtEwruJUStyZdeJ+y4u73ypYHFyVvwc1XKWXWpPM1Qyiek5gYePcW966QnScUWGdyFIZutFO+PUMPOPc8MK1a6B0L8LnsUFCeMQUAuTurFP8uuDIcZi9PhuNnNNr0GM1jBFguu4oOtsQnTY3/q2cQfvXt7r+zqBzZRKzt0INev8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN2PR04MB2208.namprd04.prod.outlook.com (2603:10b6:804:e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 13:35:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 13:35:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Thread-Topic: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Thread-Index: AQHYkwbFK9lbodl4ikWp8TqJRWAD9Q==
Date:   Thu, 14 Jul 2022 13:35:19 +0000
Message-ID: <PH0PR04MB7416B717E550463E7023049C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
 <PH0PR04MB7416DCB82032542A95F5A7599B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e49fe98c-d3be-73a1-00c0-980defe49b2a@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31cb4031-e592-434d-4b83-08da659db1f4
x-ms-traffictypediagnostic: SN2PR04MB2208:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1susZ1O40ovIKeaZl+uGzaJbVmrjPqbZF6TOj2QcacOXpVowXSr0fj2I/sQOWNPUEkpWA89v829A164Ipe1OIeB5X2dIQNvlOr7jQ7vewCmG43E58uusVyvv1UcqZWreMwKv9z2TxeDNPCE8XUfCLd0+lA8qRa6NolcQL3wmBBEn6BsLH6u3I+9BE/tN561lliHA1T6ILXLHt2UXK7rE5gtpjYroJyA/i6lIulc8cApFLdYqCssUcye9HFd9j+2Rp0bcehCmqPY6vtUzNFA87oadNOpyU+1JmtLC5siqC3FOrvPVaiVy1lX9N4I+dzOfdwcsuTjgHYZKee4V1wkeYu58XKDBEtD/TytDP3KsIY1ib5HZp7d1j8Rt28m0r1NSoGhzar76gy3j/hEffnzcHf4/A/2OB98XvZ0XucIeidkrQ1H37GZf2ykUUjjNKZ2ZtrBTC36Yk8joaCYc7vSJhnYwtLD8/U3QhjhnxHh0yD9YU7Ie2DiRq7+dOXo8hVydxWfA32MHdkheIGqhsnHLzo8WMLhRNtBGRtLq37to6p7NA92fOq5flPkqzBBzfFOTuZqNbgALRa0IUb1kTq4PSLDLeWIf0UpPKHgLyo0YHknfeldqn0imCBfmMUgZMB0bDaBy8sJjzEQHLSbDgjafeuXJ6Uic3xi6rurtBkygnUYG2nyqqIfksgM78Nd0HNpYkCV/5olaOEq/Fy2nxUKK5j8hv0MACzmRQHFfXrr+8e2dvw1u5S4VoO07I4q4NSj3G6sKpWcNQiprzhl2aU3qZXJeSq+CVa9BAIKaugmnsmvUNhWDthJZvsvxjbsNcYRz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(71200400001)(316002)(110136005)(38100700002)(478600001)(53546011)(76116006)(66446008)(8676002)(66556008)(66476007)(66946007)(2906002)(55016003)(41300700001)(38070700005)(82960400001)(186003)(64756008)(91956017)(122000001)(6506007)(33656002)(8936002)(7696005)(9686003)(26005)(86362001)(5660300002)(83380400001)(4744005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?5W8ro0/a3Zd5xEYtW/nnh3LcrHmoQHOe0wGJLZYVtCOK99pvTnloLBeJZ9mOXp?=
 =?koi8-r?Q?pE0YILyA+shptyj71nsCuRUocGS3Z2rtU7uFypBQNHkwH7GO/yT9Tw3+zr30zz?=
 =?koi8-r?Q?6COLx7Wqf5Vue8b6c8KV/tuJvKODcIt7a8g1oPoyiNlfjEMSV0CL24tTxHPzGJ?=
 =?koi8-r?Q?0sfFSmIiKWUHUjH5CkaGPiKZiK14RWq77H2lW59KfDxfefKWvOZrSWwDKMRuP7?=
 =?koi8-r?Q?ZlNWouC5DPQI5kLytTOShDMqPnxBGczeV9CidzrnmhIihqxqgzBklI8JgOFacW?=
 =?koi8-r?Q?ZFLYgEL3IOd4/VSsbM9BcOJ15PJdfzSlFFIKthsyqnpJiaI+npQ1zcCxKt1sIU?=
 =?koi8-r?Q?7FgXiVRUqi5CwQEEea8ZI4OKfvmzBWnLPQZRuosFNjjKKjvDWVoeo16+Rr7eWu?=
 =?koi8-r?Q?x0Iq0UpnlUozAoZCjFF3DQODBVKmlfYQvwLQDAyyLrTSPuZceXX4bLoqP2LSlY?=
 =?koi8-r?Q?jdDUYCXYmBAiH6laXcaWectbuhh7uipMiahbJX1xp9Rc6Zn3ZYzXmHhHssJSnL?=
 =?koi8-r?Q?FuDjMQ6B08+n2QufI7ewxRxAwWldWoZBWjZVb6h0QcXxV6EZr3VlBcQNUb5Nhe?=
 =?koi8-r?Q?PAvzOnmyXFeLVaPMcvlJuzdB4khQdKiZ4+AUoikRstz1x12pnazJw/AlM0U+UP?=
 =?koi8-r?Q?tXimeJnqDe47X2wU2PUsJ1h6rDvyVeemI6m2zDfylkepeX9O5i2tKENbH5EXoR?=
 =?koi8-r?Q?clGQBaO7xe/EHuVsVcs96HIjYbF5H6SrgKFSMWx7LHN4kMAlbpjiZt1tW/byio?=
 =?koi8-r?Q?RZ5NjMF9LtOIwNkq9jLlrkoS9rsNJntxZyWvWdN6bpeY90hTR3QgLPxKFibpAj?=
 =?koi8-r?Q?uuhDVJNr3L0CmFRTnjJ9tE0sOmESnACRuNcVpwP7plQzF/jArEUCPo/uz5bCZZ?=
 =?koi8-r?Q?hpxOEGeYvwp72IUbaGEPz0/8ihS1zvHSn7NV1+IgyUvWfWG0wKHYz2++fgC9nX?=
 =?koi8-r?Q?x22WZbj9T/6p8skVbMQYOZUbJGnORtNkS9blKRlohb9CdE8t90N7YorfYIVPFK?=
 =?koi8-r?Q?tWrHQmyqVA3F4m92+81IZDl+8ZxB61bKfOpevZUnG6SxRl3MNo8s7DcYviU6zz?=
 =?koi8-r?Q?53MBb4GkIxuWhv2msV16i6JYeDdU6okKwPFZNI59YZIxIxGEVuN047h+Pp5TMn?=
 =?koi8-r?Q?RoO5ACt8182O7MJyYBX9KxMopHamPM/3KnIiFRainOS+nOFM0fsoCAItQP+Dsg?=
 =?koi8-r?Q?pFtjIaa9CZlw+jpj3QATVcIHtJTIwZG38M6hFlFUO93fGQelfJuCojUKplulIC?=
 =?koi8-r?Q?2rqSVUMIeuD0/KceuTyJS55DCEV2PvZqg/+NvHVdSKtzyrJASqauvAh00heT2w?=
 =?koi8-r?Q?p4Z8REj5ccyBfrIY8ZbFhxF5/N+4r4caM2k2NtsUFauOuhiRMXGx8ZXeTf+J9l?=
 =?koi8-r?Q?STkstt9THeeguOfpV6XMYC6xH8VA0d1j+yuvqWp5NAgwIClktQSv5cHZIvyC3J?=
 =?koi8-r?Q?RdVQMhD8EGI9hmrN+XKmVJHlPrVodP4GN0swLt1gLaVahtZzq+otHm34moOkKk?=
 =?koi8-r?Q?wuMhZyHSOHKFc1TVXrhzvhi72zJN3ll/kR+sCwT/fXOejw5ET5GgVhhywCXR0T?=
 =?koi8-r?Q?jjvB+G8YhFxvwJgrdgQlepF/1x01g+E=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb4031-e592-434d-4b83-08da659db1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 13:35:19.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9/XodYlBQa+npqwSkB6tqJgYdoX8vInmm4CZ47Li54kmZvfAE2DSwCcY6HxgTOmTxMPh9Cv6RowTOj+BRn5+urDNerzI2o2CvekienATPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2208
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.07.22 15:28, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 13.07.22 =C7. 18:43 =DE., Johannes Thumshirn wrote:=0A=
>> On 08.07.22 22:10, Ioannis Angelakopoulos wrote:=0A=
>>> +#define btrfs_might_wait_for_event(b, lock) \=0A=
>>> +	do { \=0A=
>>> +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \=0A=
>>> +		rwsem_release(&b->lock##_map, _THIS_IP_); \=0A=
>>> +	} while (0)=0A=
>>> +=0A=
>>> +#define btrfs_lockdep_acquire(b, lock) \=0A=
>>> +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)=0A=
>>> +=0A=
>>> +#define btrfs_lockdep_release(b, lock) \=0A=
>>> +	rwsem_release(&b->lock##_map, _THIS_IP_)=0A=
>>=0A=
>> Shouldn't this be only defined for CONFIG_LOCKDEP=3Dy and be=0A=
>> stubbed out for CONFIG_LOCKDEP=3Dn?=0A=
> =0A=
> =0A=
> rwsem_acquire/rwsem_release is actually stubbed when lockdep is disabled =
=0A=
> i.e check lock_acquire/lock_release. So in effect this is not a problem.=
=0A=
> =0A=
=0A=
Ah yeah its=0A=
=0A=
rwsem_acquire()=0A=
`-> lock_acquire_exclusive()=0A=
    `-> lock_acquire()=0A=
=0A=
With lock_acquire() being stubbed out.=0A=
