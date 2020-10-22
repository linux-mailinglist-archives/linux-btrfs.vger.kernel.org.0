Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597FC295D30
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 13:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896993AbgJVLIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 07:08:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8251 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503284AbgJVLIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 07:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603364927; x=1634900927;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ikBwtNsRhtmz38H9DUcsHpoUCnGfyyYVW3xvLFveLTo=;
  b=RzN/0IIikQc2YvBtrEWaeOyxs4venoVnHa6opwtdOfwiNWlteKzAB/AS
   pY8pBBwaHoTvbBu0jdnsBufkWqousCrovZKKeG5+R/tofr0X4LYr/N257
   vtttxx6MSQpWKVx1ZPVAlzQuF2Gl176FXPGAqx+XZ+ybBY8nm06UR+OdN
   bTugXzySQafAolkUBkslPlgRs1+LP4YKS01ND/WMGfGo8X1M2NJJ7WWxH
   IEoGR2iOBTMQcRAJ5y/qZdOVOQcXsQwRhF1W/SKlThSP3TzXVfFrez4b4
   wmvcIyYFy7LBBa6JvbSnRZ9AYT1RnihqQhg7Kk5QKyF6FDMz31u78jOwR
   Q==;
IronPort-SDR: 5She+DBfPdlhDPn6yEnl0Fzjdbg9jlaIBlyfbz9DpFxqXSdEdsXOvtgGa/vsXX/+YwO5OLLrPV
 YuTzQNit51BpHeAI3iMvgG/MQSPbj9jZ2zh7105cFMl0qJQmrrRiuwsQEkPKuk1s8mseMXVajW
 BCGQ1Gg5ezwIZ03TYBlkz6e1ue91wTrOCt2HHDuR+cl+v9F0gV4HXSBxkMPtzZjJYKi5x/2wPv
 l4aYhgQt6BKs+aYIifqyK1QaOjajvUg1y+VsnM7FetsYjvyW7//jcBUI7L/POywHm3c95jd9Nf
 A98=
X-IronPort-AV: E=Sophos;i="5.77,404,1596470400"; 
   d="scan'208";a="150533189"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 19:08:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjGiGR9i91RCC4ct7dUsJfTrwY41E32B2IUH54eNerSbXsnB3MGzyejryF28GUPR0LOWk6dm+IZ9wft0+ecUlXn0snx0zovaoeRmsZ37TmJGaxUZU6I3VDvf5764F7QM6/ZJpNFyhCCxk4AAc8hPr1RdQ/kwIP6x288f0Deyj9SneHQwTuyqMdkR1WkiYMVpzOGx3XuxaQn9wikSQfLvJYx28ShwpmVfpS5uGgo8hFafgfzflwEBhmZhHLez4M+QJd/ofcGJ6RkCYkJWpUegbeA2J9OQNPv2hYmkKz/xVU+sYPwxhY7bAU1IkL8FC8qkjacKGo8fEtoYmfWYGeN6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5rNdN8EuKZdqTDgVaMz9N2fyPIxNLmY97fZeBukUi8=;
 b=fdqUc4U4jBXrB2HL8bfHDBfXZaTA83S0J8DAiVUka0cSVNSqTK14FbBO3e+1Q7ouQkGF5TeL9rMt+pkDeZhRKjkg9Q+fvBpioG2LVk0PeGibC69p1yMIeGG3f8H2TejIADgHhQMr20ifS2IKpFcGCdhVeyL6kg9pwa2s1XfZA4x/kPfY30iSbgsVBwvoZRep2vItZQYlFfmqR3fTBfzn1weci86djtvLgWUPnfbBjeitOiH3Ve/LKWgbUzhU6cThMYZL91Bwt5PzLfJL4fcat9IV1KtK/z8LCfp8uOtB4OUr+lTzz1dd92t+bjq/23bxhxuw/i6rQuT4Bdgi9CtvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5rNdN8EuKZdqTDgVaMz9N2fyPIxNLmY97fZeBukUi8=;
 b=pLh72wA3QlNS025jIqCxTwexokISYDTq+V/MXCuOvpWKgh4v0wDA0B/FMbP16I9YiPS1Cr0MCiCgtQeYSZZwpucFgD5HYIQPUKZSkJqa0pJVEb/tsEMQmFb++TqKe6GUBDnbdn/1pqKtXQLsMk7BBB5G7CpU9Pl6mHOKK26nIJY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 11:08:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 11:08:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] btrfs: skip call to generic_file_buffered_read if we
 don't need to
Thread-Topic: [PATCH] btrfs: skip call to generic_file_buffered_read if we
 don't need to
Thread-Index: AQHWp87TQ+B23e03UEykiNn5Iih9kA==
Date:   Thu, 22 Oct 2020 11:08:45 +0000
Message-ID: <SN4PR0401MB3598BD3408F30BB14A99AAE99B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <e9b1d098cd97cf275009a80d0ce087ba39267dcf.1603300854.git.johannes.thumshirn@wdc.com>
 <20201021190348.vqc6jtmppel63ltc@fiona>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68c2f265-6447-4d8d-a30c-08d8767ad81f
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB3518E91980F80D178770C7AC9B1D0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hksuDF33fIoseRi9RuZ30tf6SIo/qO/kasNQxftmAi8OnYLYKgj8AJaVTPkPluyc28EbpNaTjGZceFhRLrBkAHXM6Q9ex/sUQ3fQ3cFlx6AveuEm/qs8OoTeqgzTt8qtPcH0OL5a0lNY2p7wFNkr4CWtCdQOM0x1DEe1m27Ysuxqb2Q7aXZkNijQvmwcDaJBrrrdeCja6mULDRF07TLDRhNkLFm8z5ZITJXa/qGBstTYbHpvZC30PaFu8OfMTM/LKqu3DGGfBNcL8f5/frIX8Kgt0ZV3NO4CRZYJG5lrKLMB1l8LaMEGVfMT13sI7cLuc/3zm+av9jdVlhpRdRynCV1pdYtFlYFdi/RiF5DLcMt1s7j5VwsCQngOvzlIKYtO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(186003)(64756008)(66556008)(5660300002)(33656002)(66446008)(6506007)(26005)(4326008)(6916009)(53546011)(478600001)(2906002)(86362001)(71200400001)(54906003)(9686003)(76116006)(91956017)(7696005)(8936002)(66476007)(66946007)(8676002)(558084003)(316002)(55016002)(52536014)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1ASRhCAvOOXEqP2BbkLeOJY8jvm+xnGN+79Eiqyh1NABTGC+uKlZPtZLdak/khWtXiwjsR8dw5q6iK9Jj6XrJlZ3DNL+6DXATrFVRRP+/ycwcu3ufBb8L+nXGJHCRSODhIfcYtBh1p/y159JMpOeheWkrh9DGkN07ofvvDTfOjY2cyDYnMWXWkLOEIx+aJdEeR24AHZuCBg5AT7i9Zgep+zotMfDg2Bg25oh6duyLBsjx7d+cgdvLsFPy4J+5nt36QU1k9R9lk7oYMNirxfT6ZYP39snrTjUBZuCvK4++i3in4v2kbq39ow6QewsAxpmQ4DM5Y3e5kvHhBDmOSY0JNlyWP2wRY62jFBa1FK+0N6wcfL7RlPp34ysWGQk03RScz+jOda+fH1Ed6R7xPf/6BtEZEnJ8g1+k4zI954dpnkAxZrMKc3AuuYvN80bGnaDJmlXEQymSeLx5cTT8/WoNhTnD67fNy+za+yoYVN30CI+tz2CdUKXO73OXC9tpM9bWR7Mz2v7zA+attrxoATvIEwDtrGKWHhchxyH5AzJ8JEZSCBvS9KbtCK7wvluhvJGI0Ao/CKfbsL20hbuQQJBf9fJDMgoNxR9KzxaQenP461P8lFKV/w4DtVxGV3ZZkS5GkNR9ytDNxsAdsUIn70fIA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c2f265-6447-4d8d-a30c-08d8767ad81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 11:08:45.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8DlIDHqASKcdvkv7t1meFRkI3j3QY6zwcPG0QFdm+EhQxQRCI31WEJFx/J6Hb/UXiWN/rdftXD7VceKOxfdBa0O9UxH1df4I9Jm8LE2Ahc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/10/2020 21:03, Goldwyn Rodrigues wrote:=0A=
>> +		if (ret < 0 || (ret > 0 && iov_iter_count(to) =3D=3D 0))=0A=
>>  			return ret;=0A=
>>  	}=0A=
>>  =0A=
> You can also include the check (iocb->ki_pos >=3D=0A=
> i_size_read(file_inode(iocb->ki_filp))=0A=
=0A=
And I can also scratch the check for ret > 0, I think.=0A=
