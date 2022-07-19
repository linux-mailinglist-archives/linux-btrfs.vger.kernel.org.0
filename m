Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433A57949A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiGSHxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiGSHxt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 03:53:49 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B3248FA
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658217228; x=1689753228;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=elvDg2eIjU1yzRPlV55PgUDP9g0hOTAhwaSuFqH/bPA=;
  b=fQNauOI7R0dJ1vKHH78ROOugA4G1FEWOl7qC9cMHyKJYO4Zn5Dd8yS/t
   krHSWTlpCYZd8UhIUGNJ/ZgySjm52pUlJiPSaC9YkC3sSRAFSoz9wBKCh
   90QfRdJqEgZVLPipp8jgex+hI4QI3TFYnQkxt8J0WOjh/8c0BD4LIwtKw
   OA2FraoUaVLuAJUtu2/9WwZ5hNe+ZLIpKrUxY9Rzjqj2b9uI5Vy72Hmlm
   UEKt8GGoKi1TC/O7HlW71tmfLWhU1k3Mi2gWlMbklQWAMwvqt0UuvKjqO
   rl1/k7FaaoLw6hzIOx4jrB3+uCgXsU1IFlKZ4Bs7WX47YlSCjv0iXBEMw
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="318408073"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 15:53:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXmIoUaAwBaI1R8z0AzvNW3vbthyaP0v+gYvCmLnnLQESC47eKuPjhlNGMdtHdziFZiZcBY4ENvMOgbkfpUJCo4tTBRzZkmN3zWzIleQDdnfZ0przSeUv6obttaaJ6FSq//IBm7Hx8SfZGZQvegM/F1FeaHFQbE7D5GFfcarInQ5UDkZd2X4Swy2eZRfzdO24UH43k/rsAqtrooXUJfg5qDbPy+yGgzpCzkOApMQo0dFH09vArvXkQmcirGeWijsHLJodDj971BOVZQiaO6emxryDXXopWkjf5SSrD4kvOqfzsLNQOyM2AX4MmcKejIgDZiry1mD8VMR7yKVz6YadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUw3K8OPQrLkbOsbbbxI/2uiE7GOLq9gilTFp0QRKaE=;
 b=PB5EIY1EqG8XZgse9uDe4GOx7iiKjQc46KMfWT+b2nokHM5t9d9vutJuJLfl13YTFGZBmzct/HlMXaVRv9dIDjici+xX4SxIFWfWAyqbAbleSUt3OJl/eDu6b5CJrUuzeu7IAOkJnyfLxuUgB1zv4zgEVRxOaLPFHrelG+26bbdjUhaufunwo/DNnN3jrdsMa6m1z6bBoGZawgREifWsCr3GDb+o4QZpn6sFwXBdhCw5nQ+5s+Kd1NMBFScbvb0rp50X3oBEuWneSUdn7kvaKx4pkfWMBwgMcQWnomygnC9/Lwde081U2Z3UFPpFLh3jSjKygovqHkY5YuWqRjTkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUw3K8OPQrLkbOsbbbxI/2uiE7GOLq9gilTFp0QRKaE=;
 b=gPmwdplzR+I5HKTHVQLLjopqTxOW8j0+cpl37j3up/Zhpj0DUpZgFaXY9exu+9JBQpLnmiGS5qdQoJ+AAzEQ/GYc8qLiVISbVKstxIt/WzVtqtOWNEs8LAdyU4PrwkHUUh6ACn2Cnm33v2T2x/yq93Wofb6VhumQ3XuAu87DMwA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN2PR04MB2381.namprd04.prod.outlook.com (2603:10b6:804:11::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 07:53:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:53:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: error writing primary super block on zoned btrfs
Thread-Topic: error writing primary super block on zoned btrfs
Thread-Index: AQHYmmo60KNTJNFiCkyW7WlV5b/dIA==
Date:   Tue, 19 Jul 2022 07:53:45 +0000
Message-ID: <PH0PR04MB74161E9598C27B8CEA10F53F9B8F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220718054944.GA22359@lst.de>
 <YtVSBLTuRCED9mYb@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b81fc8eb-58dd-4bc7-8f6e-08da695bceca
x-ms-traffictypediagnostic: SN2PR04MB2381:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSkf+NCn9EY4RrAnGr4BkPoiWZwWwp27P6U9Mt0ZRMiO0QyZ4jXB58KYUSaStT+HNPYGEVJBvHIgnqsnUxRAhP2IzRww4je4J299w7QoUw1QPU0wjhCCnZ9qoIXNbFySErSpKxuC3Hcne8ynaJkijJAgUFC8rT61kleqrbU0egBSRMmmKppVqr5n1ZqI7H8KcdsHobnvqHWcBIYeew1vXl1FY7kzZcEt8soqD8cH4yoTMInbSh/WY13d7+poEhDF9dNH2fgS/6zuL8eOtHYOuy7c0ebR1c95+Ic1Ga2gbThCoTwYhE62YhDt61hJDcJxI8oMCF1Pho/ixoVY7vRUn2aVJd+Qn17I8Zw4k3nffCdfGundrkn+acQG+96QW6W1Uvyawg8kuyKvZoEHLQ3FuztE3Yy+wYXFSg4c2bcwurKX2PqePzZ1XsyDtxBwzxI6HFQqLFAZKIeIDT+hBNvptJlLculOyUjKp+QfOYPqjCS67qpyYj/SEXXtnOfGK6XY227+zYx+V0wOxUCKs+083SHJf9Nfw4pYwNJ2NjEbcSInLlwtnFBumGKO4suxHQJGeukOEtyYwJaCDiIoeeQNO2YaisXu6Fm4tedI61ucwcZ9tpchH7CwiH+N5fSlotkNUOM0Ch4Ac3l9y/kfivYEPZCpzbp9HHNzuHu920+SF4sAml+u3AcDOgoJLhXQfrIo8aAsb6XimD3x9sUpnoTbjc6RYI65DUrf+fFGcDbe3wFJWF3MqGmhz0yAzaZ0w0FkGmHjx1Nw2GUSpR0huz9kyeW6dlHWPCaifkEXbRaLRu5K/5/ZgxQYYHhb/1Ua1tFwP6mLyfhb7lBwUK7Fojik3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(41300700001)(83380400001)(8936002)(52536014)(122000001)(7696005)(2906002)(38100700002)(38070700005)(33656002)(9686003)(186003)(6506007)(110136005)(71200400001)(55016003)(316002)(54906003)(478600001)(8676002)(66556008)(66476007)(66446008)(64756008)(76116006)(91956017)(66946007)(82960400001)(4326008)(53546011)(5660300002)(86362001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LVyMbscQP9omni4A/jGSP9CyluTx6rDnW/0+iQAFkSYIEmQtao25u3yL8cVW?=
 =?us-ascii?Q?elhmbJ6PkLvjp6/9VxfQrCjn3juo3qeBWhdteaxEaiJ2DSem+8mnfHONjtI8?=
 =?us-ascii?Q?v8JuOBsxUGg9Ez+K3RMeBT/4WCWtL6nfsyS4St9P2CEjwcqKXd8yLNbx2K/h?=
 =?us-ascii?Q?1QvsYpbQs8dymWMvw9mfRBAqnHRhl5mJCb+GuqPf/X3Vhf/VKolxnYIoZfqs?=
 =?us-ascii?Q?nrtZAYORtLa3nM10RhN736amJ37re83xeg+Rpuv/4hULwTbF2nyCmQotVDqp?=
 =?us-ascii?Q?tzcITkyTP+YtqYKFmmTuAIxSf2AuZIrdmDFoc2qylp59bouYt/KLXzXp6Vr1?=
 =?us-ascii?Q?M9BD0hO2/wO/9dzTEZw2h0rK/IhGNTfIkqVZjXUyNBXQjX80MdNA2RtkUYuf?=
 =?us-ascii?Q?Tm8qvNfMVbXfmVOpvwLl6Se+KYD1S6gjvt4b9MLw1cbrM9z6LsRl3fn3XXnF?=
 =?us-ascii?Q?12GJxsp+QFWqgMop/fHtysjYnsaIO6QiBMDgupdyTg6u7zWFCsZewM2SunVt?=
 =?us-ascii?Q?UhhKwMjPsOx8xj7j4LK3vitDqlS0syw95AxfH/BMreAl/4N2dLo3mt9Cy53y?=
 =?us-ascii?Q?0ZQ8upgb7NVOPaTCKH4+9kS4A9xodt2A2llc9e43TgeaZ6Ne0BGZIOaFZ7dc?=
 =?us-ascii?Q?J+NSQsBY6ZIZnaY7JllC3HiATTkjaxYacJNOOmwY7Krw075eQasx4scOPj2q?=
 =?us-ascii?Q?TQ2bwpqRIW3SCgG9KX6CYe2jvqsGg+HuD75qkRNAjigK47I+9MADiPyfzNc1?=
 =?us-ascii?Q?Y6YdYca3kNYNy5R3m703PS+G1/nWzC5NN2uE+yxaw/f6GVU1kOoZDvIkrNed?=
 =?us-ascii?Q?/Byf/czDE08/TiKWhK2a6D4Zm0VK3aGKTazMI4pMBKMcww6TE3TVZrZP/90L?=
 =?us-ascii?Q?yfGjb8MSUBm7G/arWAEnjWQO1HQyukL/MtuBQN7/ISrJGGXZmaauDFhHLGN6?=
 =?us-ascii?Q?ul7VES3cgNT5WJHJttS17wN74YhiY9bQJXiHeVcPCovGbr9ja/ihOqWLFXlC?=
 =?us-ascii?Q?JUpFJEaa1bCBKaOppYuK57egj+Nh9zgD18QFBuBgTCoWzSFEVz+4TNqL/XR2?=
 =?us-ascii?Q?I6qIbgfFRZkik6n91Agq57KXxVofTmXL8YQslbbEt9fHizYrsxBWNbEDWFLR?=
 =?us-ascii?Q?xTS9UumikumTWCWMQ2M8dPAyPo30b3jvezaEBwrBtYF4NcQayq26yzrNVswL?=
 =?us-ascii?Q?gk7kKQb87fYkDxiUvgTHQBJs+H9HeIqsJLy/neTc5JeWClU+ybZCPHtCCEtE?=
 =?us-ascii?Q?yBRA1hP9gW4XPp/QMj6mo2zsVUCbVhWl2swYxemGcghp09ECYsfyUDR8GoTm?=
 =?us-ascii?Q?Hcmva3nKv7gKV57zdIeU9MwoMiHDz0NOrlNMem+y6Y71q52QSn5/OKyG88dC?=
 =?us-ascii?Q?pjC0d6LrkDHBtABJdQ75OoJqsGcmhlD88tmPGUrIhw7dxi8PuIl9fy+1at3b?=
 =?us-ascii?Q?UPVtq+f+IrTRP8OsTpO3zDScvRrqTC42GydmF+BcdUozfI4dhUVJANv2wBg7?=
 =?us-ascii?Q?qYyokt6+F5wFqbT+U3PQag+i2uZ/E6b1EGoHSq1ZXAMpC/uy1HrNMLLhe4Vo?=
 =?us-ascii?Q?OUe9vUlmC7hq7AIzQkV+ieequWqISJcK8nwQM6/lyINzJIKAgj+m+Zxnw1pP?=
 =?us-ascii?Q?R2j26QuaIkLi63KgWbbOnt/6MUrbkgYDy7Z1vL89YtkXyd5llwBGa8s40hsF?=
 =?us-ascii?Q?I0isAe35w+OHWhUG5bcM2ktrQCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81fc8eb-58dd-4bc7-8f6e-08da695bceca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:53:45.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9O5qfIdo9eoM8ZGYiNdQNgH9gZyvlgHO6a+/+kMnMWZbt6kBuun5XO3drRXUFgly2si5aNm0kKty1Co9mWzmMHSyr+CNxbqJQmgSUtoez3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2381
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.07.22 14:29, Matthew Wilcox wrote:=0A=
> On Mon, Jul 18, 2022 at 07:49:44AM +0200, Christoph Hellwig wrote:=0A=
>> Hi Naohiro, (and willy for insights on the pagecache, see below),=0A=
>>=0A=
>> when running plain fsx on zoned btrfs on a null_blk devices as below:=0A=
>>=0A=
>> dev=3D"/sys/kernel/config/nullb/nullb1"=0A=
>> size=3D12800 # MB=0A=
>>=0A=
>> mkdir ${dev}=0A=
>> echo 2 > "${dev}"/submit_queues=0A=
>> echo 2 > "${dev}"/queue_mode=0A=
>> echo 2 > "${dev}"/irqmode=0A=
>> echo "${size}" > "${dev}"/size=0A=
>> echo 1 > "${dev}"/zoned=0A=
>> echo 0 > "${dev}"/zone_nr_conv=0A=
>> echo 128 > "${dev}"/zone_size=0A=
>> echo 96 > "${dev}"/zone_capacity=0A=
>> echo 14 > "${dev}"/zone_max_active=0A=
>> echo 1 > "${dev}"/memory_backed=0A=
>> echo 1000000 > "${dev}"/completion_nsec=0A=
>> echo 1 > "${dev}"/power=0A=
>> mkfs.btrfs -m single /dev/nullb1=0A=
>> mount /dev/nullb1 /mnt/test/=0A=
>> ~/xfstests-dev/ltp/fsx /mnt/test/foobar=0A=
>>=0A=
>> fsx will eventually after ~10 minutes fail with the following left=0A=
>> in dmesg:=0A=
>>=0A=
>> [ 1185.480200] BTRFS error (device nullb1): error writing primary super =
block to device 1=0A=
>> [ 1185.480988] BTRFS: error (device nullb1) in write_all_supers:4488: er=
rno=3D-5 IO failure (1 errors while writing supers)=0A=
>> [ 1185.481971] BTRFS info (device nullb1: state E): forced readonly=0A=
>> [ 1185.482521] BTRFS: error (device nullb1: state EA) in btrfs_sync_log:=
3341: errno=3D-5 IO failure=0A=
>>=0A=
>> I tracked this down to the find_get_page call in wait_dev_supers=0A=
>> returning NULL, and digging furter it seems to come from=0A=
>> xa_is_value() in __filemap_get_folio returnin true.  I'm not sure=0A=
>> why we'd see a value here in the block device mapping and why that=0A=
>> only happens in zoned mode (the same config on regular device ran=0A=
>> for 10 hours last night).=0A=
> =0A=
> A "value" entry in the block device's i_pages will be a shadow entry --=
=0A=
> that is, the page has reached the end of the LRU list and been discarded,=
=0A=
> so we made a note that we would have liked to keep it in the LRU list,=0A=
> but we didn't have enough memory in the system to do so.  That helps=0A=
> us put it back in the right position in the LRU list when it gets=0A=
> brought back in from disc.=0A=
> =0A=
> I'd sugegst something else has gone wrong, maybe the refcount should=0A=
> have been kept elevated to prevent the superblock from being paged out.=
=0A=
> I find it hard to believe that we can be so low on memory that we need=0A=
> to page out a superblock to make room for some other memory allocation.=
=0A=
> =0A=
> (Although maybe if you have millions of unusued filesystems mounted ...?)=
=0A=
> =0A=
=0A=
Ha but zoned btrfs uses two zones as a ringbuffer for its super-block, coul=
d=0A=
it be, that we're accumulating too many page references somewhere? And then=
 it=0A=
behaves like having millions of filesystems mounted?=0A=
