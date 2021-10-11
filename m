Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4A429385
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhJKPiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:38:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59789 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbhJKPiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633966562; x=1665502562;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7tt8NPn/2k8+v+HeC3bytBckMBo4vEH2HaxY0ymO35w=;
  b=qk/JGqDpOwstn9iutcu86wuayN8+IZT/WcPczjcFKylpT8DuUm+s8Hqi
   5V8dUbW2mjRIMOO8E0dPnbAggMKjjlG1Z/il1ajJY1h2lx12pJ5HrbAdG
   MbLlcpUHbJXkyKNrWMxLJSl/RA1Hh5vvaJNYiilBpXEQaQtgMEhIs/hTt
   FpRWivrZ5svKeFgGJSkqKOPtqMuNO1OhBcSfs9A8lj0+euPY0JhpXg6Bf
   WpE5CeaSl/7BPvQj3oJlMWtxlwTmBmmoHhe+YQ0gaIy2enzgWhyA+VUHf
   e4CH8JCfaN04VswNAEmK8CH+9TQKNjupbbOoca+WhonnvDZfyZtuqFSK4
   w==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="187278192"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 23:36:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a97+14UyChE6bmj7KW+yFocfXRFoRHMx9vJWwcqrYjEdi0NZF2WWnWRGcvtgzdb6KNoEt8QqFAWkYNrAFf/2NIAYfcqLO65+AMH2LKeGk6AoSTxUNZFPbUxfhmtezrUy57xEA2mdrBn0j++L1ens7sBa6ZSvR5uWu/bN+hyQAO/V1Khad32E99tXmxCvzqwICDFyOu51azh971XgPZemFlbmrhIOJbLJzMpCtIsg5xjw+8FrdeCRo2YamnPxcBO5TkYg1+ezKKg5a6qCHTG9Z/fFfHH/pxs/CvDT3MJYRhqY08SqFlzLBns/IG4RnKS4ZHR1aTaMYJHp+i+IqDVehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxj3nA9HrUkjbbgwqXx0TwMOEc0pWofO9MIgR7O9XD4=;
 b=LL1Sd5BawxQUisrEpeg086IzK1ymk+FEmLdLxe17fKSZGjqG9Sf9LcaZQIU9Wam3Jt4RduhiUHkbgjxzBATDgO4CLjaA6ntmn3OOfpgz4apqH1UwipHcuylKDH6vblhEVke74Tu/uRvOFJXHjfjFHXCzoasvfK6ich2Z/rtUTxX2Kim7qWb0HVFESAM2QY/VsLumC0PZ/09zROuucbTHrunaFzoOOLyP+R4heENIykx0RRMJ0DxO+fbYL/9ROGQAhNG+srXMWZKy2DxN13ulg+GCxciBUl/SqpJRUw49DrMC2xMyLfv/wbX9LpacDw9mrxnWY7MS3ZP3xmUCoaKEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxj3nA9HrUkjbbgwqXx0TwMOEc0pWofO9MIgR7O9XD4=;
 b=OBJyuvgwDv42z9mYMzjZEVy9usMA1iBzTDcKOMWSvGD80PhhqE65RZ9kIFe/iX17j2E5CBLC/P9w9I3NNkxSxOzfeROIwG9eW/trhT565PmW1ckbUxyCKiZ8F/5yWcMxeR3bwR669d6F5NhonS257o/5OOHSAEHeDNFcxs2G5AA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7461.namprd04.prod.outlook.com (2603:10b6:510:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 15:36:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 15:36:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: use greedy gc for auto reclaim
Thread-Topic: [PATCH] btrfs: zoned: use greedy gc for auto reclaim
Thread-Index: AQHXvpDLVweW8IiL1UizTovKwpWSyA==
Date:   Mon, 11 Oct 2021 15:36:00 +0000
Message-ID: <PH0PR04MB7416699B54AC4252F1C5B8559BB59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <d09710513b6f8ad50973d894129b1dd441f2ab83.1633950641.git.johannes.thumshirn@wdc.com>
 <20211011145215.GN9286@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e58c4a8f-f5f3-4177-ac37-08d98cccd3f5
x-ms-traffictypediagnostic: PH0PR04MB7461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74611854864C6ACF5964F6F09BB59@PH0PR04MB7461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZzcSQh68bEmrFOuBdDKhaqN0ycsCWsjBCLNlV9l9lgLnfPei9zX38WZ8s5KcQDZn6kaGgtP4LBxJUbNNmT+e6XYp8AgbchArwPEgPVWo0vn+Wc0srIxUQlP8V92HRMPg7aZidiYfto21cCqZbr4UDlg+6VBnr8LRV6dH7ii8t3Lse6Py6QsGnLSfeQGbRNy3GaeWOKq6Tk8VSNZzKTKC87TimM5ZQUAyTG89gEPd+BFt6my+6jcBaa+LHKpR5/bl4x/PPRf7PgE5WiiTEaKuXqowsWPuEQ0ks7le9NqqOIw8Kv57IZ1K4UX9sQ5R/28yPpd/E41fP1Kfxxm44bMZAViL45QQd6fkGIak1C86iyx1757KvJqKHcu1T0GF00ZLAqKhPt6H21nMvhUZ/qvE5TFlsfuB6zOCkOPk4Q/4AwsQN5jo1uQXnvz75ycONYoO3oXG1Wzd8avdJvil5wuENrkW+N3Y4npvAKssVLB82DMtdQ1uciiQJfyQW4bqqGzEU80donrw/WjXiu5PotFpO3tCMGO15I1YtAst87LCHkABm6OUSNmFJexcFd+JTYqSpzPkxlicOVruAFDO16eCry11o9tEIrSxpebafteDxtG+JKotL/oHFS8X2emXPo64fLoWQPjO22EIPQaCIN173vMH8J0Je1yr4hjQKVHQU2mGgBpMcd9AEPmhAkC1Gw98/xSJSQ7WKbVD6+uBPXLSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(2906002)(6916009)(53546011)(6506007)(7696005)(186003)(83380400001)(38100700002)(66556008)(54906003)(66446008)(9686003)(4744005)(64756008)(122000001)(86362001)(8676002)(38070700005)(66476007)(316002)(5660300002)(4326008)(508600001)(91956017)(33656002)(66946007)(76116006)(71200400001)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wtxmwnmXmbNA4RBUOWvxkL4sVOkPp44Dum6wuw8o5FFAk4vcxzbaAZGxTTY?=
 =?us-ascii?Q?GoeNNCH/ySCPEsTCVzaqSJuW/I73znvhAVtmb4X+zBlA6AYt4rmAMA3RqfXY?=
 =?us-ascii?Q?A90nFPF9rwohG/uaRzP4ZtTAptJmiYQ0ioH0JFTTLnRyDf1b4ItQlySN7nLn?=
 =?us-ascii?Q?rbKb5EDh/EDqpA0LywgW6FdMkQJRPFMTED6/d5kECz7/T4sQsZBY5FEY5kDi?=
 =?us-ascii?Q?8vpnvQwMK1xdzp8gps3RdQIMYgith63pSjnyM9HSaB7o3VJGqs5cMzIbTPV6?=
 =?us-ascii?Q?vC2D37McyCsZZhR+/91irGHpOsWQp53KKDiQit0hWgyF2GM+H6FR92s2Xali?=
 =?us-ascii?Q?oAmrMUiqNLyAA/GtAc9AnvYwJ1I9pECWJvsDMZA+l/5jjVnOAxcEBHmGsmac?=
 =?us-ascii?Q?I2ovSxlmtqIyoWpojuU2bat24gVaEnyU0MtihbCLfQyl0cet8BEZWyUXdlp1?=
 =?us-ascii?Q?JMCWt+r0ogxLB/eBrNx/5/zob0TdAqXa7bfIhT2kW6n/dlnlLIMHY7PQYNva?=
 =?us-ascii?Q?49N40XXFu5r3zOh/9IkIMgNIIZ6ImYbLIvcRnu11CzVpFLtdrvP88AKx9yXH?=
 =?us-ascii?Q?HkDFbo2jkJOCX99L64rb1B6aOlncPNOL77ti5dOq5FMAu1la9aZxuGPqoOCV?=
 =?us-ascii?Q?Or9RNjRpCvIo1d4Uydqj9Xrpgb2algEIU8hT+2d8fZfH7Amtka9F3wGqK4Pf?=
 =?us-ascii?Q?x0q9tmUDVsFo3BqXDD0NwgU8sox/fWB9ilR7gEiLtxBuAb0kBZ+s4iepEA1G?=
 =?us-ascii?Q?yptWvf2nPOma1+iYjfTw0GSopKdtHRK+o4v1jXwgjArvWO/MbilVOWJHOzpt?=
 =?us-ascii?Q?boCIauGhkAE+V9VnBFBGEQE+3xqLKsM7KCgVuOzjyRxi9vSfCPFrXKJa1ZK0?=
 =?us-ascii?Q?kAbnX8VxnzqHnsBuA9h+wfNi18Et8KnHRjwABMHvvwUwD72z4NXoDtqiFd2X?=
 =?us-ascii?Q?Z8WGKSZGvB1TSCvIIsi6lLN4WNUwJlh1xxtbpyg0/L06jJ8PQvNZmHOzusyw?=
 =?us-ascii?Q?LLy7IMip0ETb1mVkH09hgXYQs6wrK6wLEo6SC8Q0xHrRRs1v7KDpIWUS+Ipw?=
 =?us-ascii?Q?pJROoDAmEJNlq4pd18wmOHzyrOa2u6Azpqlz7IvjNkA56xOa9u0n1JOtdDkX?=
 =?us-ascii?Q?80DEplwUE/+II3Nchc6Kylx+4iKlULEJYEE4xLrQbH92tPNevHdtTGzPdRwh?=
 =?us-ascii?Q?Oa0VeXG/9mwhEkAD1jYnWnEzkk7Ldrr4WQCfZDStcqLnBILsDvMWHgD6RNhx?=
 =?us-ascii?Q?3UQ4z1SOOwurcthIHuli2BrLhc3YFAREKiJMBRSrWL4yol8G2+0AqviG4VUj?=
 =?us-ascii?Q?nIZ12L2wauhim7TbqDnzAqGLiLg/eucMmVPFmojBJ4wAQzara6IXgU8odyp4?=
 =?us-ascii?Q?/RUPsmFDsgOSAZt5v7bHd0FVkpeRgPQlnhMxza1vZdlhftxi+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c4a8f-f5f3-4177-ac37-08d98cccd3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 15:36:00.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NBAzWObIkQUYbAWjbAdX7wMQUlg+FahCG1hsYp3Oofk+u8GCffg/e8MadVYt14kZIYFPCzOgRW3Un/QKqGtlzZXSherBuqobGTVvnkUHR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7461
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/10/2021 16:52, David Sterba wrote:=0A=
>> +static int reclaim_bgs_cmp(void *unused, const struct list_head *a,=0A=
>> +			   const struct list_head *b)=0A=
>> +{=0A=
>> +	const struct btrfs_block_group *bg1, *bg2;=0A=
>> +=0A=
>> +	bg1 =3D list_entry(a, struct btrfs_block_group, bg_list);=0A=
>> +	bg2 =3D list_entry(b, struct btrfs_block_group, bg_list);=0A=
>> +=0A=
>> +	return bg1->used - bg2->used;=0A=
> =0A=
> It returns int but compares two u64, this should be either a if chaing=0A=
> comparing all the possibilities or properly cast to s64.=0A=
> =0A=
=0A=
Looking at the documentation of list_sort() this can also be used=0A=
as a boolean, I'll do that then.=0A=
