Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A026D3DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIQGpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 02:45:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3773 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIQGpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 02:45:31 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 02:45:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600325131; x=1631861131;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=y58FxjKgoEvzsHALF2hbGln3kKr4dGDje+dOUBjYWVY=;
  b=rvqsNJKTaKhPECcOgMw3z8IZRE56n6rcfyuXe6vd0I+lUhmiJQt42GFm
   pTCTOYKnDmnu6pmvI59PkOP++OP6lZYD9WipBQtNE0Xpk7Zg0Pw2s14uc
   VfPwaLgIbbujv2HpCNG53tAkkIKEsJojkLmNRfoW5UDtXvYwaKmjsXf3D
   sv87g3oV/dyio7nYqODu0/3RDUprA2xFaDzSTezu52dAJ1lX6uWfSkhE8
   82cB1J6+O49pRnJxHp0iVRIKnC/z47/BlaSreGMha6wa43GeOEHmUFUZi
   KwK3DQt5wKJ1hY8COKnwbsrCOh68DsQaY/igTlOzUjlV2hGRkHhh7cEKL
   Q==;
IronPort-SDR: J82nm+BnP1oReg3YNjj7e+niwNiK1kDDQTDtwB51YXuz0/CgDCyRx7McGBjgdOpZcGWUc82+aE
 N57sas8zSNvpQ4CX9pW2e4EaD6ILMW+J8LTWq0pCJUejXxTbdCTQBNi7/bu/aMkh+JZ7XUPrMp
 sC7rN3Zshh1tSbuqJiHeu3LxMNKxkQNejM6M4uLUgFcpzj986qrABnWTaCszQ4CQyAQFf5z6yw
 QiKC+UxF3sJv/DTNOhEwM6U0nBxSpb+YZSkjYsT+X0EVFgFQRzU8P+JD4W6MfWtoKL4Wk80nAi
 2zo=
X-IronPort-AV: E=Sophos;i="5.76,435,1592841600"; 
   d="scan'208";a="148833528"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 14:38:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+k+D30uRg7Io6bsgMcx9/EqNdpvVi/SwizN2njNxRzb0BeGRFLSDcudT/Jdto6S+/TKpYwQOLJs0D2y7xl3HbgEhmBVsHxGTZ8/OS8MbIcEvh5ow6HZi8wphimaQTHGPVMMEaSDxqa2n3svwZUFCj0iRMiqQBS/r5Q6MHR3wZ1MAx6OvHoXwoFE3P78q24AC0ba7aXd7UPHQNa0aeYufm/KLNi8EhjE9Y+z09R7b+sZDntp449wYuEdK6bcc+I9n2cM79wg39Q+qAp0tZig8bW35BiUiPRjrPo8b2bJpVr8pfCv7fmNwDMJG2BVEkzCYSpyXNRhUP8Vp5TKt8997w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y58FxjKgoEvzsHALF2hbGln3kKr4dGDje+dOUBjYWVY=;
 b=UbsaqbETXQVIFyFcqlyhMT36A/ZDpid3pdk8sPyJWgwqV+pROTEBdLErvhyqsAgDxkAye2R1VGOvnefIRXaSrBNEOS4gHFJuTashVQZlD2TrWBmei6JXfsThCXXTHhEVud8+gt2Kq3xbLYlm8RZ6rqxEAOL+P7Ieg+X44MhCcGPe74s0tPKsy25uRXTiJ8k9AH9SyP+rXJwI3gsF6Ulu8NaUuz8dSgQ/IaMY0slWlFbGpzpX+XgReA939EiOo2PvGhMBjl/hqmFpssjkRLsRy8HjZ4yU5vBWBxsaviI4l+eCgjyMr76wHhEpMxfq3ZIbClDG7n5RUfM/2vsOkoOrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y58FxjKgoEvzsHALF2hbGln3kKr4dGDje+dOUBjYWVY=;
 b=lOPQGx4f7QMpdVaVEc653WyQj2wlDj/Nmem+Y2IdxAR0RiWCJC688juAdJk9f/MbRi7kJUJT5bcVvrAtwgh5fwPotihbl2tRoNvDCXksIOO0ql5oWQUYlTP7up2vPT1Ug3HJL0NlIgJY5fESZLFGqA9wtoeq9F4JLUE+nw63Z6o=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4318.namprd04.prod.outlook.com
 (2603:10b6:805:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 06:38:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 06:38:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Move btrfs_lock_and_flush_ordered_range call in
 btrfs_do_readpage
Thread-Topic: [PATCH] btrfs: Move btrfs_lock_and_flush_ordered_range call in
 btrfs_do_readpage
Thread-Index: AQHWjAFawEFaaPs8dEaul5K1rEYa3g==
Date:   Thu, 17 Sep 2020 06:38:11 +0000
Message-ID: <SN4PR0401MB35982F874A92875B1D4DF65B9B3E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200916081401.31668-1-nborisov@suse.com>
 <SN4PR0401MB3598DDDC1775BC43743D09FC9B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <8304a98f-479e-45c7-1e4a-c2370aea55c1@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:fc97:afa7:f5ee:f696]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22dea8c4-ef00-49ca-75e5-08d85ad43f4f
x-ms-traffictypediagnostic: SN6PR04MB4318:
x-microsoft-antispam-prvs: <SN6PR04MB4318355077DD6DF5560AC2F39B3E0@SN6PR04MB4318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0OWfViAiHfZH6h4uK0qcg2JTm4+UDPSOGDdqOk6e936ODVtFRZkg/APY4E6FeDVmvtQhD0+y8JFQxKkpgMq0kLZQDqkO8m7CYIMdsDyESxRYLu/yGunXLbC1/xC2lDJnBfI2VPZ84Yfr9X+Pnujv4InGbbu/6CmrrIwm2hmVVjJvcPeZvDCKap/SHviYtNdl1C6ZMmQYheiMib7Hgu380KSBWVBqIK4HeLl2qxk1RAqdV6WF3Tj3SucZ0QE6FMZmFPftL5nCpsP8Md5Z58pTXBOYhu+dJ7F+E95uN65YkCC/sgHHV3Muyi1ttJEbYxsh7VMYVWipM7ePeAiDn8cjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(83380400001)(66446008)(110136005)(52536014)(8676002)(66476007)(64756008)(71200400001)(66556008)(558084003)(7696005)(55016002)(5660300002)(8936002)(186003)(9686003)(2906002)(91956017)(316002)(86362001)(6506007)(33656002)(478600001)(66946007)(76116006)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BLWxJlQ8r2KUv7j+iKca2Tvt44zYQlgPviGYste8lsVlAGQEznHdZbPwnTtgrAXST6Q8bRtW9KbkrYZ43SaFjktRTiZ0NoE/LL5YKV9zfot/cwOg9qG0AzBlPWOaMoebDVmzQGcFR10EEai5Wx2mop5y7TQqxLG6yDmNQ6qA3C02v76VUJoJ2WwUbGxqxXz6MvsYZoYMoWfbDjtz043cjxjOY7V/litr8McqmU7GI2iQKitvD4Lo2vxewevsqQa+oIibSjb/jEyOT/BhYD7PRIM6svXvszXSXs9tD5t2Is8dLNi6+2b34Od6VMisezetmpPZws+c1+MGqMIgJIKiHrZHaMSRVNDUYcsFYdoodyCPDgqPPzcq5uipwRclau4LkoL7CbXCEMbL+ZKqiqdjScgtOXQAadyQB74Dak9RaMhvzNh5ae6IZdmo4gJKojuwAU7Pgm2UNtyR3Kke2GrIr495u5gYprTqvMQcor+HWBuQYsBmduNiJXPkecR+LunxX5DO3XgCykjyRyr3XaUVj+wMDh4nf2igaf/7I/8ocOGLL67aruUpP4KBIyyKbDeGxzN5Nyspv2Yzld7UGQcRrIrTskyI7ho5E12xY/TVPHnt2XUokqzG3YEdx2yXtHD7hv4j9sJCAS74pa6uFCINjV4/S6AlG1yhG+cMnMVjOX7y/gZg3caEmM/sjrUCpaNA1Qfwz8p0BR7YrXwbWOSdZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dea8c4-ef00-49ca-75e5-08d85ad43f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 06:38:11.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UASvlTAgpdL1hxk7ZOGPLS2UhNvVF7E2jxFak/nzgeb7NYHKgyUClnvBoVHSP0foPQVuCGNndCRtz1gPyziX3E1/jiYf14xl/LMs/UBOD/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4318
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/09/2020 08:15, Nikolay Borisov wrote:=0A=
> Actually no, this conflicts with btrfs_do_readpage call from=0A=
> contiguous_readpages which results in double lock.=0A=
> =0A=
=0A=
Right didn't see it :(=0A=
=0A=
But why can't we remove the btrfs_lock_and_flush_ordered_range =0A=
call in contigous_readpages?=0A=
