Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611F31CEEEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 10:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgELIPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 04:15:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5432 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELIPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 04:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589271345; x=1620807345;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1mOd1PpcVxAPOKVpxCJ5rFyQ/ZKgxww5QFerlcWPR50=;
  b=TRAxwXpsDjKMsg/suf9BfK0Rp/vGsV7+f095js8rbeWiy8xmwcNa42zJ
   irtQxVxweQhlkrcs3yBRAvh0Fp2QUCp7jFnwcDqRwSw2DAMag6cuiQWnk
   F2rZGPrmWm1IpEORbOh0hiz9h3bPSHK1BMZ1+FcYifPMKLDGlIxOTkHWB
   5iTlw/u/yAsQE+YArRi0mDIxvNNecQRq3uPXD4vQNvK+QrYkcM0UmR38x
   iRaTjPiRLYtxUcowOalwq0eRKkoVOwrfl6Wa4qxuqhZHM4ILksm0Jkabm
   N7bOBLAPA8aqverIAV74EO9Oi0FmZ8l/hUzM8RDmMargGWYROv9ScwP00
   A==;
IronPort-SDR: ogmg+m8/GpjRcpMkDRzJn59DqEXPr6E903FOPqlW+gIT94pMGpkqqyxvJN01DhttWxhwoXoY+b
 AY1fySOYtuMjr0n7zQ2z2LUtVRJAt/YoxHTe0Df6qfFOBkf0iB4LsGCpcLBL8vWGfUkyP8gQMm
 tudDh2rqO5gpwJfdguBQRc3NLay+gGDxyjWY+YOAO1w+zA5QjYy1F5fH91gXJxwdm2miBtYTWe
 ZxGUKnUUdVnmmvT9goozI4MsC8hi+RMkEWoWcWseFGUW7pBWpctiSebdXnTWtFytjr1bP56sS/
 qSM=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="246402051"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:15:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABCczrA4GaAcH2Q0l6bd4Uf0+DBtVmjFeMsAYXf3Sxmt0GkoPwFTfN5L+hrsD5u8wDbiAiOAkxeLuh8MQwuR3BV70QEYYML7delK7vXTDHgYF7M1kV5Iq7oFNoyjbiOtP9qgn1cJy8KV2PRXRW6mMaCSYjCr5kC1FimkM+EvakIm0S+VaWCGp27bWIwXhY1ha7F2dRyEQEjhTxTFvbdZm8NxDeQeqRzZe7b5fSFTL3h9mb+eV4B5casm5LcwBiWD/EC7jWbYQGfO33OicJ8oDqq3rl4WkwBWZ2OCNFtU8s4eRTpVK0Gl6TDwAT/yGNTXEyWOUMmTc2+XQWRf5rOTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/DrfRndjDu31JfJbGOUhdaMP+eShaVaQbL9W+Jl9QA=;
 b=gSB0HmM8VxXZ1N3UJrVEa157Mj/mTi6btXqcu3TV6ty1Tybb0+ZgfwgSJwCdjU98O4ZcfZNtL1vbTE6PQiSwsIJoSicRnnj+8LlaTj9TbRlrStOIdTSku4D4vUMfPs1obiZN4pyg9u+KM92F3fsueJ9yFzpzVfiCU9P5Lq+VMpYCSqjSBlq9N6wTu6UdW+8Wb+RWc9P5nSrJL1iQgikEvqdyxpdkCLmqHGnABywsIF54Y61WRAgyx+bs8/EGxy51cGllldSCaHsrHgD+f0spKi6JOAIt3Dpk2BootoJAmPWsu0cLxYzXVFclYEha4pk9wxHlbhy1WTTj439jsVkatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/DrfRndjDu31JfJbGOUhdaMP+eShaVaQbL9W+Jl9QA=;
 b=OJbeXYVNeT9JZCs4u8hOundUfJilNrgNV9dxeAYZ1bTqx+eLKdLUIbfsvuQNX7FKGcqnovVVu0Q4/2a4Y1P9OuuDCYsbhEubTUF0CjGO18WsCfe7As4Pr2gfzIR8x+DTWGpB+yeMi3qT4WdPGF/YjrziQOLnjaLgkJA/tjYbyJM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 08:15:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:15:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: unexport btrfs_compress_set_level()
Thread-Topic: [PATCH] btrfs: unexport btrfs_compress_set_level()
Thread-Index: AQHWKB+h2yr9rMcR2Uq7UYxD7T+asQ==
Date:   Tue, 12 May 2020 08:15:30 +0000
Message-ID: <SN4PR0401MB3598DFA809736C9AE6F79AFA9BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200512053751.22092-1-anand.jain@oracle.com>
 <SN4PR0401MB3598A397B1E8CDAE64C51DF59BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <8acf6de2-38dd-034a-c666-4d1861f7b175@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df524d93-8225-4417-6870-08d7f64ca2af
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB3679D9DAC097058DF2E466D79BBE0@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3AjCfnXxoKRwbqy56w3w4uO+Usy8c485sQYhd+B8UI+D0rU94q3uSYCgs6v8Acp/bF+XsfRr7NgRtCjKPe6dx/qTinFx8YzCTmjKllCza4mnXFr/dx94rTCZvEnRNiNwss/fwCUwperIG2wwBdag2PLDOET8PJMW9arCHGXEXMNA0TlkmgqZ+JkZeY+eVXEWVFFl9qoWVh/0To/IvjKkcgtr+SBCNMqjPhSzC5tvh1EEF+VUJFU9RxLhEgURSAY9hIht7B2YQFU3WivfbI63mseuzv0sS2f15IVmXwNmqg6/kqxkm4XxAIwZAB9pcvlHo1Iqu8HAcbYLjCHYWNGdcCqWUgHD/EGQdIjU5X+SKeTNAuhfO4TOWMOni0Gq7WlenyTYZWcv39XV+m5pPRJeg+bxuxctcjhnaBsuZ2UFzzC/8/n02Mp9M0NFTIU6uhlkUK5mD/DucIqyLidUPIoRf/Ze1YSKyHEGgUmcHwYtVPMb0eHQBpnAwuBUW2mxQ2YDFNYgoPUSy0fWTtUT2yS+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(33430700001)(64756008)(66476007)(186003)(52536014)(66946007)(33656002)(26005)(4326008)(5660300002)(76116006)(66556008)(8676002)(8936002)(4744005)(2906002)(86362001)(91956017)(66446008)(55016002)(53546011)(6506007)(71200400001)(316002)(478600001)(110136005)(7696005)(33440700001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: y8VsWsb3voQH8P/XtZGHLcCbvuPk6muA1ETWvjimHmplwYMyazzYJiiHvoDY12V9Y96Gz/TIfdAWIt1ArOZTUTMPM2zMcetu+UrKPPWNh+5jZ1db7da3O/YeF9OXlabhQI5AF62bysy0bE9M3APS+KrAo+Z8Az0us/zve2S13oA2hEOlG1q/dPCUjgx0T5uopick7eDIaieqfo3dKDUSLXbYnxSUi4lOCEVrPKPwCegI2h4T9NNC9NNIC9ii+QKYHEUlHc2r5VoU1qjl7t/eJ87qU2OSdLg+Zf2kTArsyvR8PToj0Qb80eSMvHgcM5Dt2VZNQkEmQ7N6HYs7UajNPFFCKetZzHMAc0jdhYMpOUtWv3ICBDRJXtOnU5iagNDCHvxx9MB6scYIC8S8Ey9puplGL91MuqY2qJCRRjT9/rCnKGFEoHgqGv8uXp82kjLII9KXIa+PsqPI/ADiKP1j+xbRnZZcCjbCXh1aoyDoTju4hOoRvj83hTjEuaioqDig
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df524d93-8225-4417-6870-08d7f64ca2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 08:15:30.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6g5Zxad+IteCPWqknwAxk79qNI/CkeWDFSllsRBC4gYIm7wuy1oEl/WKU8Id+TEGQDmPeaIynKlDH8J/sfz/RLFswU/CWjoOmxLFic9Rgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/05/2020 10:14, Anand Jain wrote:=0A=
> =0A=
>> Why did you move the function?=0A=
> =0A=
>   Oh. In the original code, in compression.c the function call=0A=
>   (in btrfs_compress_pages()) come first before the function definition.=
=0A=
>   So to avoid the re-declaration moved the function up.=0A=
> =0A=
>> Apart from that,=0A=
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> Thanks.=0A=
> =0A=
=0A=
Ok, thanks.=0A=
