Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8881F4932CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 03:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350730AbiASCTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 21:19:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44360 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiASCTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 21:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642558791; x=1674094791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DAuOr+XabKyhQMkLvL/r7470N34y49WBw32m5RZtWBQ=;
  b=Jqk+tLXacEa5A6UraST/Jgq6FedusIaq30cBsIlViqqLlSfn690wERon
   IwJCUl9WFIlGIRSVlWqnjLGQAxf9l3uQS1fjHRB5ufGEtJYiGXr4FEfr6
   uQWj/tweDJ67oDJbSjc8BJIygRdCuF7AeUBYrIFQ9Ra5hvldM6yL4pCfW
   Y8sWNtEj5jz6eY8I7tiujK6XyS4E5ahtMrTH58Gvntn9FVA4zmRUobxjs
   p7kbz+w/781XCVMf6/1a8XhCAjcTRPmvvtgKEABKQWY7Tq1kjMGJ8f2CH
   46nDYh98LZOyDbnhL2v1F3eHjaVM8IW0aEawLXHQgfCDh9LoolOdLkpb+
   w==;
X-IronPort-AV: E=Sophos;i="5.88,298,1635177600"; 
   d="scan'208";a="191815869"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2022 10:19:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InTEqT6jsvk892YD6JN2IJ9t3KmWuSCBfi6mHptDhN573sFY2IgngMrGlf0QULIX68Nmr+pUesC/gbCf2Ljy9Z/VGxWBFLvSjJcL/FkSTbWTD9yA/rruIv78YE5fLuUjwcTzg5WIgFiXXaz8xm7HIcOzjdJolw1MY+rIwDAuzXgi9+coeHC3i9KEJEWKrDFif1adaVrFGuzU84ZAHvMtTqseDGRqrFcneCKHCi/gin7KDOdNfhgDH7mW5xA/rKG/phBgbj1hTR5yOKMssxI/R1I3b6rKEihh+aXW+E31/AO4wNrhuOAP7ct+/Ll1HYmaZ15cCI7VlLsdRxAUTuYn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTfCLEwSB6v0+dJ++mjLgrU09JUiqHoARi/gx9tOdyg=;
 b=AKPI109mkP9CES7Nh1xcdjB20YtYnl2yZWRWgwi81pwmwIfAchVf7YuE9vJmLMmT10t4l3Av3AnseWTHlzd6z2Jw5nCeY9CHCDR6lRJ6P4fxSnWBbJT085hE0MCTPvbTPdmygtT8g8vDrcjLLrxchhnafIqUFqqc54t/4dG43U3yTQGqCWKX8GFAz5xZbMq5Fpal9ee+xDB2jm28DhyQxNvPwFAwigJX45R1hXSxd6aVqtlypCDppSm8ACQhVTQvV79wE5ypLmqIlZ+Z9m1i0ehHgpxJYGM6zbUvI/4bxHPoN9P46OU/Jg1D23WjNUVY05Qry680Gqg7IRxW+4Ctew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTfCLEwSB6v0+dJ++mjLgrU09JUiqHoARi/gx9tOdyg=;
 b=RXYu+YAUQsEiIty0tyc81LkgbVWNYC0p48U+Kj9I9BTUi9EVocIF5XHpSGgP9LuSx0QVXTeDLVq9SfX3tdySOX1EUIJgYWRYKgdKxwwn1JcE1OfzcPonCPhK0N/7eaAMpuBMoiNUubto0JtV2qtX1MBJ2NB5ZKlBzaGvNxc5JVw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB4395.namprd04.prod.outlook.com (2603:10b6:5:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Wed, 19 Jan 2022 02:19:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 02:19:48 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] btrfs/255: add test for quota disable in parallel with
 balance
Thread-Topic: [PATCH v2] btrfs/255: add test for quota disable in parallel
 with balance
Thread-Index: AQHYDDBF6px1dKX200mi0jU2SDomEaxo2+oAgADBxIA=
Date:   Wed, 19 Jan 2022 02:19:48 +0000
Message-ID: <20220119021947.bfqssdofxdiuediy@shindev>
References: <20220118055721.982596-1-shinichiro.kawasaki@wdc.com>
 <YebSuDGqX4RoxpXq@debian9.Home>
In-Reply-To: <YebSuDGqX4RoxpXq@debian9.Home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425ed0e3-0004-4250-e52b-08d9daf22acb
x-ms-traffictypediagnostic: DM6PR04MB4395:EE_
x-microsoft-antispam-prvs: <DM6PR04MB43954EEBE4C9E2F58EE00ED2ED599@DM6PR04MB4395.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ROZpxQozntbVDkaeeiTHQneKymEFegJlp1n7ulSvl0u+Wu0ZBGTiI2/fxiuaMZAGdcXZ6FvhBej/YkD0xNjFxYN62kv+4M8Ypr3PtiCwD5a49EqjNHV7+9h/uR+0BUYD+yryq1SV4Cd9Elwti1sVXgi6EyYAlBKdX/ZZSABU5k/T3EEru7mioxvLPrIMRzd46+wcEUn1jCGXi5pKVmkkgt3QHqZ5UXkLbHCZPFRr4irznrOPPl10BRGyHmJsNfoDbLN4Jdkjc4mzTaMve8y/tNrQoYVlZOTZ9pc9SKFM0/82JrgQ/0xvD9Q9AhK90H925iSkQXP1X9gV8XIr1Pa8pEmmdQ/dNTFQW/tfUeLDw18K+wXuhdNUeiUDzscbK2mKZWpdu71IjpPUhiroS7rOKTyiK4OvqrC1NMC6sgIXbdZr7VJlLoCjAiUtGG32xGrX9WAxnjjs0l+52+8SRt/cqhhZ9+z6mAzTyjBfzwCmQjG7DzQDkhLDPvVQVIcz3tWgsDKtQdTeiCpX5g/mjmWm5nG267a9GAct4wRqAMWq+eEJPHsDVUIzHiM7QAU0d9CPKUuCzDoluxeNzbcdTuFmQBSScHDE60ABes2B0+/ilulCsR8mTzPUDjWKBUsk1M+Yk3Q0K5Z7r/RTEB8UiKO8pz7hBk+hQ3fjSGzv7SCt/4Rk4wPheRhLdbR6n3bPiepzRb8ggy9JTdy7/hMxDrf+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8676002)(38070700005)(6916009)(54906003)(8936002)(71200400001)(4326008)(38100700002)(6512007)(186003)(9686003)(5660300002)(91956017)(508600001)(316002)(33716001)(1076003)(3716004)(26005)(82960400001)(2906002)(83380400001)(44832011)(64756008)(66946007)(6486002)(122000001)(15650500001)(66476007)(76116006)(6506007)(66446008)(86362001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?th2ufPKei8zJZAJOZvJeMG2fPtECWClbm9mAjOw9LdFjiFP5KptMu23N+8w5?=
 =?us-ascii?Q?ENRAD3wmVI0MoGqUjNUazA4ukFV7uOlBG4TsaafAu4/EYoEDwZwqWkTpsrHx?=
 =?us-ascii?Q?8Z6bf4TTSqqPNatdGV3yL7CJG968xXIwxABsexNADBNHRvx1AMBOCcyGwB4p?=
 =?us-ascii?Q?vVzDxFUUB7ered9a+uKF+6kZMAR3kMBkVcNza9VxVGAc63gROgoqRAUJgP8v?=
 =?us-ascii?Q?UNMkWNnbFGhHtS6S8WES7gQ6nsZqfAmzwr5oB0Bf/939jPJtQC1pqXwPOU0W?=
 =?us-ascii?Q?awH3c419Ez1l+dvUaUN8dyP/pjerMCw+Bh6QJDGZYQFyAepVn9OaWSca0+2/?=
 =?us-ascii?Q?JAfRpPMBLh5yXO4YeNs4s8k3iCh2Jq5LMHffGmrV2HfYx9uMe69XjnTHVqyS?=
 =?us-ascii?Q?0DGH+fmy1X/6Dj4jX4+f4BZ7CFSOR2wwQORs+HMxOnpmxKUYxS7mHLqrFdq7?=
 =?us-ascii?Q?WARzKOA/j47PUCzGZob08CXsghzp1Ers3j9THdmnid4Xt9Gy4LLNMxmOsyv0?=
 =?us-ascii?Q?T5jqIk14PvQ3dSJh3H2oZaW0/o04ciSmCoaHcHLAEr36OcphSJSEAa/PkuzI?=
 =?us-ascii?Q?qOMCWL1WgEv/mqEgoYMYgG0p6e17dWaqio6asMu0UJ+t7CpwEeItksdAz10a?=
 =?us-ascii?Q?HCcFlyMNeTmYKnmrckwX3m9tv1GyDKrgg9S0D0WydXRGKdx1SGBH75KefZcY?=
 =?us-ascii?Q?IOF77VtBVr7z3WDZcSnGNVOBwhY1ComqgjhIFcjqTLIp+XASTtvrotIm3TZA?=
 =?us-ascii?Q?cK0NLQNI3iMTmZJnK9lgAfAFu7ISbuwccTley00K2fbzCIJM26FjFH2ZrwtZ?=
 =?us-ascii?Q?BBCAzO5kxE/EN/cyg7XbHIIocU6UR01NGFbW24T2dFqLURV1/oQ3lJ/T/LBy?=
 =?us-ascii?Q?8iiQro1kTmpv5pzlDqKgwH+AXq3+sDlYxDPVxwxk27vQEvSyztfPiG3DBH73?=
 =?us-ascii?Q?6gasrJ7m1u6U0eFqCWw5Iie35l8GLDddetLB9EQdsJXYBqGz5UQ/VqiJNbFg?=
 =?us-ascii?Q?FuFkPQED6ZGIINnnnX+Hc5Os+PtuEK+Y3n7jbJ3+P3g5UZmZ2us41Mmgynxt?=
 =?us-ascii?Q?DS6c4loEbZezJoxFwVevSN+NxP9LgOqqkjll0/ckcpsBEjOhCGiy6prPrQ9V?=
 =?us-ascii?Q?ZVd1ggcd5XDk10+HJHsem0M9i6fUqBaLanP+pJcAcg094QfJtqJQh4CxLlI1?=
 =?us-ascii?Q?o2E2N9eEq51D+Avsfcx+aPq3buNjw3q16D4b/WfeeHuxGDf8G9YO0UXcVVgc?=
 =?us-ascii?Q?kP7slTF5Nzd7HTplLVB3fDBro7tqXj741/s/f9+/45U3w5aqm/NV80eAUfcq?=
 =?us-ascii?Q?NB0VxKxkdWwDCbyoKCXM7GqFuFg/Mh+7O09C7Q0k8nWRHS41k09vLGGgrZTg?=
 =?us-ascii?Q?odGfam9U646iAgfh6cGePw7SNrgFYY7/t0pVMnVRZYxzz7Y3aQlrUXC7+h7i?=
 =?us-ascii?Q?ebC+9PqCec7iizb6uB35ediFocqcyf9zU+fmn0tntovt55FTQImnztswS7Gv?=
 =?us-ascii?Q?bkAajMM2IfAu4WsUuB0Jci/y5rWee+RsLOPqeD5jPOK5K9Zr3ihvS/mRYBfp?=
 =?us-ascii?Q?y9CvxapyROSLzhuS423GKTA4t+vq5AAaO8wqOsrclAbgajDjg71Zn9kG33QQ?=
 =?us-ascii?Q?x3DU+5nZ0C31GGO5yM3d/bUPFikLNMtiJIwAjeFi4UQ9RFAeVunjMv4uCw7C?=
 =?us-ascii?Q?0pjrCqw9JheARYjOPOTKqyZwgZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF680CB4D6A2134F9078BD1A06421EF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ed0e3-0004-4250-e52b-08d9daf22acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:19:48.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPWRaQRCgYM3+0g2nVhw4e716uElP7BZKj+FUNvyNNYkmw2JPfnTEElHqfh7pEf/GkILQp6DK5uWn8nl0lj6YCF/ROP9jmY8EYjZtJCVGqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4395
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Jan 18, 2022 / 14:46, Filipe Manana wrote:
> On Tue, Jan 18, 2022 at 02:57:21PM +0900, Shin'ichiro Kawasaki wrote:

(snip)

> > +# Run btrfs balance and quota enable/disable in parallel
> > +_btrfs_stress_balance $SCRATCH_MNT >> $seqres.full &
> > +balance_pid=3D$!
> > +echo $balance_pid >> $seqres.full
> > +for ((i =3D 0; i < 20; i++)); do
> > +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> > +	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
> > +done
> > +kill $balance_pid &> /dev/null
>=20
> You need to wait for the balance pid to exit before terminating the test,
> otherwise the test will fail often when the fstests framework is trying
> to unmount the scratch device (with an -EBUSY returned from umount).
>=20
> And please do like in other tests that use _btrfs_stress_balance():
>=20
> 	kill $balance_pid
> 	wait
> 	# wait for the balance operation to finish
> 	while ps aux | grep "balance start" | grep -qv grep; do
> 		sleep 1
> 	done
>=20
> Like in btrfs/060 for example.
>=20
> Other than that, it looks fine, thanks.

Thanks. Will update the patch as you commented and send out v3.

--=20
Best Regards,
Shin'ichiro Kawasaki=
