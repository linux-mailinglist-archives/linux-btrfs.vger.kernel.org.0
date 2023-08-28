Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E378A3FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjH1Bhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Aug 2023 21:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjH1Bhd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Aug 2023 21:37:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0198CC;
        Sun, 27 Aug 2023 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693186649; x=1724722649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FI3qUjfrv4QBRwKJAlexsAig6dJMJSGi4twgaM/QR8c=;
  b=qlJf0oUaPg4g8dxbqXIMER7VoNheFyaFBc5cCL+jpxr7ZkKwi9pzvHcE
   KqZU1qU/vir/NSRs7cD3p5ew0opx857BXOUfGzVG8BFxPF9uIYKR03sx3
   WG4qVJ/na4Et3Csgci6Ywij8HP2UfPBhnDO+QA5ywecmOjdxUQNn1WRpU
   7ZAwhFN6kJFzwcfkZ3hYYyJcsIsURaqvVZvjgzptLaAzo+jXy+Jg1+Ae1
   upFNTr8f8YWYpTUBSfV5LP6FNJCy5N5AIJ5todulQAArsadCln4TufEl4
   kVUm7FZBQ8VLIH2AQdVksD/6lRz8o36T5iUWTBMw9DyFu+z0UXvzcAL4R
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,206,1688400000"; 
   d="scan'208";a="354309047"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 09:37:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReVB3BDhKTk0iquJxLnuM0w4jggh0B3oCiCHLkignrCBB6c90dzVKUdfcgMPp2GLok7TP6lGo38/JPgwALJ8vDpcTua9PPyMy8wMTJ9twKAH4fvtphCUwRMTAIDzYXAWFMIbxWTFpiZl3sfZ6hImpkrpxQYawSIkS7MlH23V7yyot1vHVRMxxj92j/evjCDeM+JNwO6axUODk1O+nkw0/CbDd/OC/8tDK/uWE/DUYZ/RnWbdZrz15a6cTUchql/+3uOerf2E+DYKNPROuAu2r3KEo8sjri7ozyJVnhMrfBbXOTIaueftgzUk/8x42Boi6GxXkfqDYjE7tawrq4Z1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqL8PpCmI5HAGp+quTXLpeJZ/0xbW4Z+cfB8vSL7KSQ=;
 b=JMeSXel2MzxcsWAjBbQbTyr+JgIqQisrN+iDAd/oaFrHK2CgRq+HtDhCZTo0K88V37CaDj8P8FIo6nnsmBztaMyfC8Bo4vf1s94e7sICAeuRT0NGQWGTrno6yuFs/EKQUrvZ+ddA1g6vTRTkg4rOTYxKh7Ex1RRCJJw3F//7JnBUUsYmLqgSODqX0K8U/LGt2sN4zM7Q+d5a1dqswYB4JGA/CEAH5XtH2udNxy5rrnNXUPX/Yss87agpDQN/xomPc+Hs5aj2ImSi+n6caqiYSDcget9Mtan6i83PZbi9GzcFhzAp1ln16JXVcrtceTvhXd42eCyfBMpMxEYXShTAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqL8PpCmI5HAGp+quTXLpeJZ/0xbW4Z+cfB8vSL7KSQ=;
 b=ojg6NLfUI5DJmY1xL5lZyJoq3usRB1B+PAX5MxwP7gGT1xxpq7cDvjcbzv27f+vChj4+E7V/xqs37NKXvsOtDWF3IPkKmaDigxx9y54mlO0XOEKBf2DHxb2E284izk8Woa9JVo+gvG3SYmNhheYtnGatvXfaaYKTZIU03nTETuo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8316.namprd04.prod.outlook.com (2603:10b6:303:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.12; Mon, 28 Aug
 2023 01:37:27 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9cf4:8ade:d9a3:98e2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9cf4:8ade:d9a3:98e2%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 01:37:26 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] common/rc: introduce _random_file() helper
Thread-Topic: [PATCH v3 1/3] common/rc: introduce _random_file() helper
Thread-Index: AQHZ0/7XQi+0iGosrUWqBqOtr/p02q/7Cz0AgAAFsICAA+d6gA==
Date:   Mon, 28 Aug 2023 01:37:26 +0000
Message-ID: <smcdbq2ayx4vvs2lxevjtax2aikdvdps5zuc7ii7dl4ef3xa7l@pe5pdyblutks>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
 <20230825133948.oubggt74y7cmci2j@zlang-mailbox>
 <20230825140009.4pg43yyprmunrxkn@zlang-mailbox>
In-Reply-To: <20230825140009.4pg43yyprmunrxkn@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB8316:EE_
x-ms-office365-filtering-correlation-id: d0adc8ff-aa06-496b-c8ab-08dba76755aa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lky6P4OOWXKgNo0OWPS860UvVzfz6zEt/9FPfTxgC/C6QZ1O+8dgdahe0VGllfej+ru5MOHoCaHx9Bb2iXEfUgRr1PeNpE6A+92u4MRaCIn6sMDqLWd4prJ8NEQDKft5RJVFUJ/28HgbahGjllgkyCh1eeMG0i4t0+9lJHY6TLC6Tj2dWo8d5B5ToTx1gyq/c/GVXGUmFCjD3FOvHNyw42dHUEQCoXUoFjJp1pRGaK52ry+P91ilBwTLd9xGsv0FZXjimD8GJPjGFn5BFbZxaDyMjoU61w35+qQst/0Wb6MgTATQPCtJxDt9cyicxl4XqcBa1H1vFamRHcDZQAEGe9dpht+uzH7rgxkdEdPY8LZ6zgalFMtkwGg2Uuqn6COapVyM1UTBsFpYXGQeimH5bXR/pThi8HW1MmfIsWwwig9FEjEKIadEPTp/bTApQ3H7r66zkDghJRBuJxxJNf3N8vd60A6jHOXdplG+znfikt6XOiYSh0go1UqFPg2/D2bTnFaSfQv/da83NMPCInmqr7qlNRw2pVzp22jtee6nQuk3ebXXASI84KO5QGtZQY3+v1UWyrEqLG92xePmG5QHWl1PRg4xrl75iZZ5KBaJeieoux8+mghcsfXdWq3TtEl/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(6916009)(316002)(66446008)(91956017)(54906003)(64756008)(66556008)(66476007)(66946007)(76116006)(5660300002)(41300700001)(6486002)(6506007)(26005)(6512007)(9686003)(38070700005)(38100700002)(122000001)(33716001)(478600001)(71200400001)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xh8CFcTsQ7m8eg+xS/91/s/GY/MZ6apHIWYCNP3jx4OVhgNrTd7jc8/1Zr2+?=
 =?us-ascii?Q?xuBEOqJHg0J5CENWAhajluwHeXBY1rNcU26vj2BJ7bpMlXEDEb2UFMLbyL3W?=
 =?us-ascii?Q?pnmxSMrY/ho2V1eXkFsdQR6kR7qzhzQoGaNoO9XiUJgSOF323lDLez/+Jcrs?=
 =?us-ascii?Q?FvbNKM3steg1dQCqEqMSCsgrnwhGKUXJogrjEka+KSRYTFvOqPAxyi1GlLi6?=
 =?us-ascii?Q?Un3BsHxdJOTzB8n4ArNcHfD8Qx+3BKSbrwd5zK05W9rvCfJn7biFNnQvDGPu?=
 =?us-ascii?Q?PjHNTkjKGOaHMSwljjzYUfDx1jugh7eBGuFOuQ3EKEPGfNEgQTAMBhX5ujEj?=
 =?us-ascii?Q?xQMgOVo3x+uXmly9xjfGyOGNbSQeTsR5kksFTIGi2pVln5IkgKOAoGpzhHfU?=
 =?us-ascii?Q?wjmK6eObNh7gls9l++yAPHw2YJUX7hxYGvcn/fBtzOnDpK+li/9AMwFZFMuY?=
 =?us-ascii?Q?NCd0GDM2z1FjAKWST0kv8HBFbuTWzqW2YV2TaDJNFDCx8LFdNFRmE7ygft0+?=
 =?us-ascii?Q?vm2+xTfuAlsL9IxiPue3rOuUti/TGPLmPfxdcXoqE01KW+gaquW94KbAHNry?=
 =?us-ascii?Q?ratGm2vNHkmPG1qw/qP+4HUJXhdH0KXU1kRWTbLNDv/+wL0baGHCwXIzWvI+?=
 =?us-ascii?Q?fbzwlTQazT+u+SiVj7p/KpNDmEG0UTW/a93+NFfoYPhBEgwLkbUlVHK3o8Do?=
 =?us-ascii?Q?0hsZY/iMgTUMzHED6EyRYS3ipn5A/su5pHo5egR1Ez3zuMBWUyQ/gQcsDvJ3?=
 =?us-ascii?Q?J21EgGjM4QOCGDHL+uP6ksB7FOwty+AWl1asbonAUVIw0Rw3RY9CYZNMDDbM?=
 =?us-ascii?Q?PeV643usW7QKnBehL5eaKaAC4g3JMlNTL6qQW2OtxJ9auWVWHuMswwWAwwcm?=
 =?us-ascii?Q?rXSwt0mJS46QfKY6c37QhFqAzeOjn57zcWO/JGJkp0yG+8in49x/bAGyzIYY?=
 =?us-ascii?Q?lA+H2dRI8GtkcBGsNZAKLgBxdX9rekWvp1+R5JM289JGnwB3V5sr3HvdJxUt?=
 =?us-ascii?Q?QBB8/se6at2iuWulnm6ezoyVFanCXIvgkdIGXFAmPQJ3SfAwfO9J8ZxAn3Qm?=
 =?us-ascii?Q?fjBPJFA/sIBE4aaDPyQ7p1sAoJjP9m+3+JBLr0sVWWUdx+Zddl85uWhgvyXY?=
 =?us-ascii?Q?U+CAQDyFeDpgwUeEU3OjSPOTSxyJA19y3lZ/IiFeVSU+ZVeaYG7Y9F0BtC87?=
 =?us-ascii?Q?CE79VmV/0BZfXt1ACzn72HgK07QGgx65X6JGa4kJB4LaYm3ASYG5SpNUyv+9?=
 =?us-ascii?Q?9drr83o8OH57JIVaCcn1N4AkBXSAZ0XmSQci2jGDKsRuwzvu40WCcZOC3RQo?=
 =?us-ascii?Q?pySMQeR5MvqFHm97jIdNdHnHyQmIrw1DVvrRVpIQv41rHk/NrZTB9XbHgpgI?=
 =?us-ascii?Q?3EhV9VgKyiY5ON3tdqh7wRMWy3jKafIe5oUJssIk1q4eDIwKTLFK+1iWXnRa?=
 =?us-ascii?Q?zndYbh9Ems9kXpTqtqczQE6C1rlU2qg/im6/B3d1fiDp8Zt5jzOulf16BZ9x?=
 =?us-ascii?Q?EbOIT7V3Fliusg75p3y7xaOLkgspURndKDmPyyU30F1dCFkHsh9kgkxzIGJq?=
 =?us-ascii?Q?xUu3smT8+kVu6iNZSs2233gMpPepwdP43V852evYE2c0H41ByGIBPUCMj91h?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <490C894D77CF354E9FCAE6C64F58F79E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JTDgQMXi0dVaopiRRKvEpt6Ubq9Wq05FMrOzw3bIhQrTFE9T4YQ51aDDnyY7b0obaFkq8hQkbxd75KypheBYdyc75usbGggQr9pJqKv9y4Ej8qWOYrrIgiqR75pE+hLxk3j9SktiRCLFwi59E81NEgAo66NrofttmAPzowZT5gKc5kEpEme8QBjjCye7NqPPF6+FSG5Xpp06PCPB9Eoms4J62bHaKZznUExz5+I94oUBL5jqyb/ijoEkOP5+bB22xNIK5w3OFqG/P//nnoJFsgFtqf1ru7c+gePWFWSQ5ssczFZ9MSz2y1VCTHzMm51Vl7j5xCQTbX1vB0V8xKiB9c9s0h2T880VOzygXhMO1ibIaF67ezHGJ58+zF6ssKQD7+6UhDNP+RHnf8BO3lEqF035329djeb3X3oa4PZCIbO8tMQjhhRQ1tCqDE99s1lTEtL5bkEYXDeWp4w2kmU+/1gNGl4V/M/vDx80TcxXnW3oDdABvCdcSM8hFuOLWXOJ0YCNJ2B4i2/Ia6JoT3HxjVX1d/AVtkULoueUhEa/tcIbR1EFmWH0GR5fyIvwbge8E+On6T2kabLgE0Z6qI2ex18oZ6HuBtBpuATKr8q7C+VibdtYyQHGV9rlRYg3dmp+P/DIm/bNFgOdvKo30gVlTnP16ceqpmAuhGWDdVI4rLuSoxfBV4solXjGjtvsJjnvmEqcZi7XTFBsWK19qw9vOu0VoyLOU2h/ihU6dqRboLGlFpDIRBLVxuxdZ0kVdVetNXOSQPikssnbxiGjc2zbr0kysWlHGv6Nujsjh8BSbUv3lZrXFa/C82rnMTFyRncr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0adc8ff-aa06-496b-c8ab-08dba76755aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 01:37:26.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrViVLcoQOYWjiqYF/vafG1DR8eOY88rl5DjzgyNgkWSmNduasvvJ8MjyWOX3aVNC36O4Dasr4tFBFUe1o0Ryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8316
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 10:00:09PM +0800, Zorro Lang wrote:
> On Fri, Aug 25, 2023 at 09:39:48PM +0800, Zorro Lang wrote:
> > On Mon, Aug 21, 2023 at 04:12:11PM +0900, Naohiro Aota wrote:
> > > Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
> > > random file in a directory.It sorts the files with "ls", sort it rand=
omly
> > > and pick the first line, which wastes the "ls" sort.
> > >=20
> > > Also, using "sort -R | head -n1" is inefficient. For example, in a
> > > directory with 1000000 files, it takes more than 15 seconds to pick a=
 file.
> > >=20
> > >   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
> > >   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s=
 system 99% cpu 15.536 total
> > >=20
> > >   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
> > >   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138=
% cpu 0.306 total
> > >=20
> > > So, we should just use "ls -U" and "shuf -n 1" to choose a random fil=
e.
> > > Introduce _random_file() helper to do it properly.
> > >=20
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  common/rc | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/common/rc b/common/rc
> > > index 5c4429ed0425..4d414955f6d9 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5224,6 +5224,13 @@ _soak_loop_running() {
> > >  	return 0
> > >  }
> > > =20
> > > +# Return a random file in a directory. A directory is *not* followed
> > > +# recursively.
> > > +_random_file() {
> > > +	local basedir=3D$1
> > > +	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
> >=20
> > I think the "1" can be the second argument, for we might want to get a =
random
> > file list sometimes. For example:
> >=20
> >   local basedir=3D$1
> >   local num=3D$2
> >   local opt
> >=20
> >   if [ -n "$num" ];then
> > 	  opt=3D"-n $num"
> >   fi
> >   echo "$basedir/$(ls -U $basedir | shuf $opt)"
> >=20
> > What do you think?
>=20
> Hmm... nack my review point. Looks like this makes a simple change to be
> complicated, especially multiple output lines. I'll merge this patchset
> at first, then we can support that second argument If we need that
> feature in one day. Or if you're interested in it.

Yeah, I think so too. Currently, we don't have "shuf -n N" usage where N >
1. Also, while there is a plain "shuf" usage, it is used with "find".

So, I agree we can extent the function when we need it.

>=20
> Thanks,
> Zorro
>=20
> >=20
> > Thanks,
> > Zorro
> >=20
> > > +}
> > > +
> > >  init_rc
> > > =20
> > >  ####################################################################=
############
> > > --=20
> > > 2.41.0
> > >=20
> =
