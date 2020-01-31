Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8301414EDAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgAaNnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 08:43:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14801 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAaNnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 08:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580478202; x=1612014202;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7MuhgMuPBuxOv1pqW1S5azSUyTYlhAgh1crRlwp4WRo=;
  b=gKcS+oxE0UNcjGWT+tYSZloVLQA4L7IU3sSkiFuPB2Rve7QYLHWp6EcW
   kIN9pI5BrTDp4hHiFvuNDP2PDlQllwj2WONoOA6ZSzpgYJRxvgLPqP6LC
   YWr08nfBVPKtIw5JmrYXaSC1i3upL5Cf0AQvkpOwoh+uHrxFmzaTSPuNi
   5jJKDp4Z35l3kI5ImfNnGFYhNdRaqevQeqdj1jpDEuXu5ojKU5MpjNuKO
   8gO6P7jo/+nMW5W397dJVWLqj3ForMr9mNZpzG3cRvOOBn8PLdvAlj0BN
   buMVGCbz+vj0kwkK/vnLDHvRyqPygMC33zUz51oJaDjLK45waihv9+0AI
   w==;
IronPort-SDR: OY+zB2sMV5MWkOvlVxA1aQGGg6sNqKEJmNsdd9SNkOJPt7tIwsbUUWGTlx7JYe/jLQEvu2Tn9T
 h0v0QpKwZPmxqXAUR9IKRFrMO3DM2LDdEf1t6f+UVcgWD27aXRL0o+Y7v/NefC2m0WZYcsl129
 5xdal/NDrJ3sKIK6PTB7p0hR3FdNoBMq+wfSo2TvviCZeEYGUTOiiexcoG0q1PoBhcOjk4j2mu
 g6WDvXB6wNAMzxldvWlI9BMoLqJLiY7QtVDO+CSjDfJPg3Jz56qUQ+Sd1sYumR3HWnwcyiWV+0
 gm4=
X-IronPort-AV: E=Sophos;i="5.70,386,1574092800"; 
   d="scan'208";a="133186509"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 21:43:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiFJDn4UhXgKKKgjGCwwdMD41DS/mozsuSS1aPu28gzSE3rfaDyS7LN33QKBrdv4xSbnu0VmO2wSon8EDK87tXuLq8xEh9oUxbBXd1vub0ClVRA4Vvj5hZSrgvERFXyoougPzWFkJ6qFkYTTrfSZ8EVIAMbkG1sadBxrl5Xbduqt5XL9QCS3I3WLPVe4GJPds2NVEFWUpGAkQNqnXR/I9xO1b0tJsy34Z9GV+BSHsfZ9OPzGggeQ4Ii6qeuip7JCPr3cLqbBFIQKkfoGgLUBC5B8ZUBNt+1dSzOX0ec8OB23iEKtJLdkSmm8jaZVs84qG6hodt9LAzZ6iBzafSlxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MuhgMuPBuxOv1pqW1S5azSUyTYlhAgh1crRlwp4WRo=;
 b=jbw/VUnrQj5DVsrqOG7QlB0aYbQN3yZbkoYTGTVhyNgYmZ1V1do4yQPis51ghqZMLwdCsWrL4t6d/EcXRod4y1VXlZE2XxjMDFGiK82dU/SS+UQy47MQiNxei50yzmX36qC3YYyBEXSyTYkLFP5jEpm4fV5UA3HIbg++H3e4RikQDQe4/iZI1MDCVgEmuMxpiVVW+RKxSUJOF3CG57FE7ar9lgilhqiz8fC393A4JTAVKcT8P3/OQo//HQeH0qKoKce9+/3fj/N3thjUCNTXevBC096nfidAlYWh8LN7yRQl+FIG0gf/+xaOVA2YB8WzD0tU489jhBV0VQ9rGnQkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MuhgMuPBuxOv1pqW1S5azSUyTYlhAgh1crRlwp4WRo=;
 b=uUSaLCzgQDulVwlMtoTJUJayfzZwNhXn1pfJdkw+cFL56++b9Zux3P5UdN+EQ7pbWA11LSNl3wQ22snQ4VYSDFfVbVcVT7y4xuEcNlLQ29FasABHW+gDtWpEbjdwRlSR796aJptzDm61s8NLIhe48UoksgYoU8+QUrxFyXx4460=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 13:43:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 13:43:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Topic: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Index: AQHV1SrKCplaciq1OEKao1x65qqI1g==
Date:   Fri, 31 Jan 2020 13:43:19 +0000
Message-ID: <SN4PR0401MB3598374A2D00E21C275E5ED59B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz> <20200130133921.GA21841@infradead.org>
 <20200130161606.GV3929@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1f83f90-297a-41ca-f6c2-08d7a6538881
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-microsoft-antispam-prvs: <SN4PR0401MB3646A063C1F90495C8A814CE9B070@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(186003)(6916009)(26005)(5660300002)(316002)(8936002)(7696005)(54906003)(66476007)(52536014)(76116006)(66556008)(66446008)(64756008)(91956017)(33656002)(66946007)(6506007)(53546011)(2906002)(71200400001)(9686003)(478600001)(55016002)(4326008)(86362001)(8676002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NicnrXHnU1/6L75y/vket/6vhs5B+6goLlxPwPTGuDOlq/4vS0LlTNRV8xbIeO1Gjivz+1GZPAnZSAaCCxfpkVsgQUNF0ZbRL6FyoJX2Rl2di24J3UVZ5Mz8xZBvTJ6IKOaIwH/tdjM5gS/sRmUGIrmjB44Cofq5UF9iJ9N0oy3uBGt+yRb7uaSXB5TqSLfulACwTg2Ot0MAi02uZB429PfjHQ/T97eJS3SRuoWIGgfYzxY2q9NFFLKj3ljWxRhAL05vLNP/BTHrhewDmiQLCR8gI8VdfJp9F5AEj5EMrP3TRJCcsF5ITFA08PD6TAvL3oME9UgB89ZJVSXPYJ4CsVzPfzX/1FeyPIZZG7QVa2RzWLiWqdchQ9OW8MIOFeOWAxD1fsCkA4Bj+I8w6GnKBz3prAeLlZ/QHBwJ+RKja7pLWR6OQBSJ5Iiuyr8Uk6D
x-ms-exchange-antispam-messagedata: 89SGetvS8Douxj9nBYrZRoDiW8JTcOwNTcvfJeDqPkIw/86Vt3BW1HdhqgVMR/8q0L0U2B3Kbx9FneONGK5S/Op/+7QgmUI0AdVQ88F3uBeuPlktL+odKuTtXeLOvztmAEGoe9vAav9wnBGuLuU19w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f83f90-297a-41ca-f6c2-08d7a6538881
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 13:43:19.7240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qr77nzuSp1+LnpCzVuMrNFzFSNsdtTRsz8fkCvORQOFks8eK8E6GsZhhBIs4oHAUQkCX9qBuPoV5BmMRfQNX11JqpWBn7IBIu4GKWzIYLNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/01/2020 17:16, David Sterba wrote:=0A=
> I'd like to remove the buffer_head interface in two steps. First remove=
=0A=
> the wrappers and open code the calls, so the functionality is unchanged.=
=0A=
> Then have another look if we can optimize that further, eg. removing the=
=0A=
> page cache.=0A=
> =0A=
> We've had subtle bugs when mount/scanning ioctl/mkfs interacted and did=
=0A=
> not see a consistent state. See 6f60cbd3ae442cb35861bb522f388db123d42ec1=
=0A=
> ("btrfs: access superblock via pagecache in scan_one_device"). It's been=
=0A=
> a few years so I don't recall all details, but it was quite hard to=0A=
> catch. Mkfs followed by mount sometimes did not work.=0A=
> =0A=
> So page cache is the common access point for all the parts and for now=0A=
> we rely on that. If removing is possible, I'd like to see a good=0A=
> explanation why and not such change lost in a well meant cleanup.=0A=
> =0A=
=0A=
I have a local version now, where btrfs_read_dev_one_super() uses =0A=
read_cache_page_gfp() and btrfs_scratch_superblocks() uses =0A=
write_one_page() offloading all the I/O to the pagecache. So far this =0A=
works as expected.=0A=
=0A=
Now when I started converting write_dev_supers() and friends I wasn't =0A=
sure if I can/should mix up read_cache_page_gfp() and submit_bio_wait(). =
=0A=
I could also convert it to write_one_page() but this way we would loose =0A=
integrity checking for the super block.=0A=
=0A=
Any advice?=0A=
