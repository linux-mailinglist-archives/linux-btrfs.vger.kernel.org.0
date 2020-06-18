Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96601FF173
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFRMOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:14:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31623 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgFRMOF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592482445; x=1624018445;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8nipZ/aQD8+YchCnB0iP3UW9EYB89CoKh9pUyUUhCSk=;
  b=eALbahZA+dBNuYI0gs6RLqeoVEAs6RbS0pDn10Xk/SIVdOZWIxqY0O5Y
   uSenXBvGdXJKfVMpeTAy0y5SB75Dm3ax85Se2E+RjxsNSTuCoYvAqKZNm
   g4LgOG3RGSx692UHUW552/GCkh/DkBEbCrLf3SQMUB/PyanDstAeWfiuQ
   HU0q+xVCV6SzaxF8SYrbbOJAIbgaFGLbH2TRJra1gNBpPijIe8rx7Nufb
   wDkm0eCqhQp4nyK9BYqxtfEQf0BfeuhnCSJXTq09Fp/moOWoaqMUQ6PCu
   Qup8PPF2xo6RceGkmvj2X4pKVPwLa+vMZNJe/2tj+QjHKgTfR58b4Rqq9
   w==;
IronPort-SDR: 8aoYJ57McxzyUowOYQbG16ZcgGv1OdEavkpQLQnhQYc/2FdXVbnDjiGV8j3IzYyoked3vOezyK
 BPtFvniYk5wM+m6VuAUD2sA1TEQ9YP3JPj56RWp1r8iGmOsUgoyAL4AkUfBNpnGD1oY6LM/Pl1
 rZwnASMrPMPO4Zldzl7Aa0QS1eOOscKWVjWT4KJs7nOrfgON3/qn69tAqm5YVyVhf6+rEY+SqF
 Ig/7y7ELwb3859hQoIavbKsUBdNHTp32oalQFqaq9fCj8kZRvJ7OtucrDtx+QQcPP9LJJHjgwW
 WZ4=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; 
   d="scan'208";a="144633174"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 20:14:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcY5BxnZZ+pfomNr1rnTGgZyLqpQnIdmgrJEtAfdG2TlNPOSLS4gR2V00eHYBXyI5gT0ddYwD1TxFhKiqKU4nClo9+J/GUDpGMiqQGTWBkuSwucGr8skCCL1vSIGGbKwdVPLdbUF7UeE5XZTT5S2lkOKPTBbC/th+Adgay2iJGxqjdtkXfm0sfKA9HItpMvoniybieLZLNtDchHhVkChs3KpEk6VD3wdS5k1SFr7JKYPYSy4tWEL0GI9HseRH+j8d84RyX4XxQf8e602Q9lBqsSuPkRyjV7JjaK1u7ykIjOGBkRYwuqYGKiYpT2fiXhwsco/8je3wQUJtZDMNgeiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEzmQZBbvjYnOCcYFTdChTG3cPNRIndJl6SQ6PYQy5M=;
 b=D5XWIawly3vogErQ+ucvHhgppVrbBtPK2QVQby8dLoeJXrJxyCMe53fW49U4le1BTURDr/QvpFyiCDH2pREsIcXjej4abHLwf9xjxt9fUuvjpd7cWB4VjAZ4ypAYWiXOuRKYEBQqNskjB6QOynO0jkEO/w11miZlggqKlLqOMGme2r8yNef6R93tTdK4Lr/Y3AFEM35LFOuTweHs+2Zb5v9g389v8pkviiRhADaTh407N3gCSRvPA4TGFa3q6+pBKDJMs7xTOo92kknTRZtfLpThIxNM8Fx7bb2RRo8fTeBv1OrcBL8P7j1Z5swotZVYLcHkp5yyZt4YagUOqZeR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEzmQZBbvjYnOCcYFTdChTG3cPNRIndJl6SQ6PYQy5M=;
 b=ytqDG9iGhdHDUMMkEWEBo1Nrof+GKt6iDMoszpzjweEaYXoN1/PR7cZqBkDpfWECvZZJK1UCsGu32mhgCylkrk/xiMAmYxzqSxzgWd3LK8gQ3uUQBAD1ouE45Whihagng4JaCH9G8QwxNeJ+zG2SClWC8+3idN2OdsjlsFTz6t4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 12:14:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 12:14:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and
 can_nocow_extent()
Thread-Topic: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and
 can_nocow_extent()
Thread-Index: AQHWRUUT1geF5HZVm06wlCKuAvaZYw==
Date:   Thu, 18 Jun 2020 12:14:00 +0000
Message-ID: <SN4PR0401MB3598970C6EBE38409083EC8B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-2-wqu@suse.com>
 <SN4PR0401MB3598829DD37CA07C8B130F9B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d3bf5a2e-7216-eaa6-e253-0004353b9e86@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ca3bf3b-0be0-4fcb-272a-08d813811581
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-microsoft-antispam-prvs: <SN6PR04MB38852AA6B264BE61B701AED69B9B0@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W8JmtX74in4bPwrJauujZmUZA2D0+E0bi+aCTrf/vmPBYr6cEaDM3SfD7WwMCihYWjbxn0VgwoZylQh3snGd3YP9sJvSGYdz7H+WrGfmWMU8I6cv5gy+hnDwTS/H4mXthDL6L7E0rbwoNPp1u6UIn25sxp751kblyAhgRHFd3ZmhtErsHL1YJyhLWfY9//TKWY7M1DMTgx77QzC0G6dl5wu39TULtZTMhTLtW3EhGzoQ7IsaKe+yZ2ZNXKtj1ZaXMnvOasJSs52RPNacTAULo6w8u8UVmoI9gq6fjdKDSB8VYwriXKP2+aWNVwDc9Ziu0ZTX0Al8qorbt99DaoRMNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(83380400001)(478600001)(9686003)(76116006)(91956017)(7696005)(66946007)(110136005)(64756008)(6506007)(66556008)(86362001)(316002)(66446008)(5660300002)(53546011)(52536014)(66476007)(55016002)(186003)(26005)(8676002)(71200400001)(33656002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sTTV4A1+/uYNuCJ27y3f9GaN0FEqgh0bEw1nHZMfk/9QrhaCOGoPmJXDWDV5F+mzL/SOIvucA6742lWTP0hyIrSJV9FdundVDRZpxaYnw9Mc+hSxy5/OhVuYSb9/lQxwmeQomMEPj/jeT6J61kNDI4UeaEu6309jsfNBaqmGujxuDizme2/TwZzLqNdUYOsuiqLYAP7RiM+eXoaGbJpU8+CfkSGRSzfbG16IbOhPoZkFdpjxpR0RdcY7WVRdB82FPWhnetgPPPyP9sYdOzbV6FVEv99pCIc5lH1Yi0lozbAzfMbTX/F/LytJh6yFd4PfSF/KaTr+Hd2M+mKbXh9RSiCTkUQbZzJzRLPqF8HpUjJDGSYdbepKbBsnQ8nZKxgeWn6NZANGXi6ryG1/0ZxJSjS+2Rxmi5FKKM4FtjFl/x0r54u+oWCBOHfiUHOMqBaXUnK+9jGag/9jQf8p7yZzx58REvwXtcImxM4HnQbPTOIIgNrB1LiIhlCU5osSDn5L
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca3bf3b-0be0-4fcb-272a-08d813811581
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 12:14:00.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2eaQJwkZ+go7VeLMDFQNOvPnsMoqkHHeeheNK7B2xizEPSa+4uzRnY1PHCYqSr3dBJkHLx7PG6VPb6nU+ozSOpt18m7nzydS94kgpXO+A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2020 14:00, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2020/6/18 =1B$B2<8a=1B(B7:57, Johannes Thumshirn wrote:=0A=
>> On 18/06/2020 09:50, Qu Wenruo wrote:=0A=
>>> These two functions have extra conditions that their callers need to=0A=
>>> meet, and some not-that-common parameters used for return value.=0A=
>>>=0A=
>>> So adding some comments may save reviewers some time.=0A=
>>=0A=
>> These comments have a style/formatting similar to kerneldoc, can you mak=
e=0A=
>> them real kerneldoc?=0A=
> =0A=
> Mind to give an example? It must be a coincident to match some existing=
=0A=
> format.=0A=
> =0A=
=0A=
Sure:=0A=
=0A=
/**=0A=
 * check_can_nocow() - Check if we can write into [@offset, @offset + @len)=
 of @inode.=0A=
 *=0A=
 * @offset:	File offset=0A=
 * @len:	The length to write, will be updated to the nocow writable=0A=
 * 		range=0A=
 * @orig_start:	Return the original file offset of the file extent (Optiona=
l)=0A=
 * @orig_len:	Return the original on-disk length of the file extent (Option=
al)=0A=
 * @ram_bytes:	Return the ram_bytes of the file extent (Optional)=0A=
 *=0A=
 * Return: >0 and update @len if we can do nocow write into [@offset, @offs=
et + @len),=0A=
 * 0 if we can't do nocow write or <0 if error happened.=0A=
 *=0A=
 * NOTE: This only checks the file extents, caller is responsible to wait f=
or=0A=
 *	 any ordered extents.=0A=
 *=0A=
 */=0A=
=0A=
See also Documentation/doc-guide/kernel-doc.rst for a detailed description=
=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
