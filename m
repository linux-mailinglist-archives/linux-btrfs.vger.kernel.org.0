Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98537BEBEA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377753AbjJIUtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378034AbjJIUsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 16:48:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02509C5
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 13:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK3UB3f9so4tw4nyBdAgJIzX9gd8d/NGm3VhakiAFG8liNE3jetm4LbJtqySkKajLPGXHM7Sh8XwLzyaf5X58Gn/ozNtbd2606X4V3QCB1BQo+mCcuRciFwJzMBY9B1bPHymDT/WR9y9lPo9Mf4KxCvE1wsmB/TrAGi4vdzC6FH9Vvqgzwmw/X7gFvIU5YDw3Bl1hrl7rbOt3DmGyKmQ7fjxJfDsSq2ORybWJkw4cUMWVq+nxjcH9KtEK6iHI0bqZCjHjsw1slFRQVxo6dJfFmIzK0Sf59Xih7iPrqnmgLsC+9M3dROzH5dkvyyoWKRMoOkiGcA7b4M+sxeo50WDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoHgQo+qmvHLd8dSX1NQLbXhv3fwNywnb2xB+aeGem8=;
 b=VIJazbIkvpwXPF1XY6vQHbEORICsm2Dd2HlQRxnz+cBZ7YgyP4A/rB/Bwy1eMMFnjF7q1NrXbJD+zGBryYPEVhF3n9PBI+Pu/IZYIDKY7ciIjEgE4BFWKAd3QwsGZceaO5uHZj51F8HdlN4mQn++mUyJR26TT8koSbscPrgP9ZFdNM3fyTJcb5E604HseBzCxnyUF/YsubUxW7DtAWIztEw3nGKT0Hf0jPiKKNMViQlfceKpkmzsIzSIdhnnFBl2MODTMBHyGLAoPpLxnuSNi2AzmxR7rDKAjbCIl7sgOCoyJga85O4S9MvcWqzR3CmJK2Mtu1oOxCFMoURKIeI3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoHgQo+qmvHLd8dSX1NQLbXhv3fwNywnb2xB+aeGem8=;
 b=s4RjfKO6LkpDuSyWI+R4pGtZHqhxOh4Bj45f52Ok1F6qNm1r9v3cKLwBDBx5WAEGz899rr2NT6zh48JzVWQxuqA0TbpCXUxbBMijowKGk+NtaDmbhHkl+XOwHIbfvEA8MhtxCq8M1O1shW7JGjNQn5MTZvXXke3WVsvtqnwSIFChAbjUN+5KA3960E1jgHGjONJ5wQDipAoB9fT9gLwwpf4Y6EGxQmdXb2m2iVGHYuIifGhmwQIR+1osKDaP2vdJPSfRhL3StoSLB2EyiPwf66gSVYnfyIUrHOz5psDIc4kXH8OEVWIXejNiZpgteF9V0X/3YhUiFaZyuzU2A84nYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 9 Oct
 2023 20:48:49 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 20:48:49 +0000
Message-ID: <cdfbc6c3-d43e-456f-9616-441c3b50a1dd@suse.com>
Date:   Tue, 10 Oct 2023 07:18:36 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: perform stripe tree lookup for scrub
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0099.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1cf::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: c5acff3a-2b5c-409f-4652-08dbc90923af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85lN3OsoibcWwCgHt+NdwAy9aAyKODFGm9hIIxTHa78mBhSIDURH0V9vHui+9E/3Qupu7FmuIpGwmA0t7pMzcUMEBx1/a7jsywR97Ih9lbdglvH9IwEKBRAbpAiDA558gd/3p0ossmmOtXSueciyzJCK6G+1cp6n+uF71cKl83sNd9fJFEbQQnE358IZv0bgY8HFSoAhZ+KLBralFUowF88l+HUXFIrhdkVRmfPFoEoP3XpRLZocYL3z9xkn7yvyns8OlLKnotirGEghkUCeHhzeKcFsERToMq0iqlOO1ocoFHvpGUyzwbIQ2+LqPGe6v5HWXR2T2wEt7YVSEme7K9io0MCKJkCZ37asdMrT5t4X2tUqk6RUS3Jz0BADuF3+uR64T6xtgAEl2ujdb9xD9LhFznyZTivpcrINEPiah9LEiZXXANVE48xxwV/8LqSGrrK1gRLRwDWXSoF4PtNsmx0X+zEZs+29oU3GMGLQCBJ41ZUd0T7PcMT4PY1hx0fD1JnnVx0vz1cZyVCkNAV3DQq3N77udnxfbwCjx+y4PzG3i50LE2MZ3tmbFovzinVIqtnm9pCOeisz2D551vggUppQT9nwQ1894H2Sp5GmnKy23g6kLjldQsrn0RQ/VYDnMg8YFla68txenNYuHZnLHJqQAlmXgutratgAN1It25p4cvbYiLabfDHiSclbV+swWi+5aPDBW9yvppaKL7Yc2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(41300700001)(31686004)(110136005)(66476007)(8676002)(4326008)(8936002)(66946007)(66556008)(6506007)(5660300002)(6486002)(26005)(36756003)(86362001)(38100700002)(31696002)(6666004)(2906002)(83380400001)(6512007)(478600001)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTB2WDhwR1dXZGphczZEWmk0cyt3T1NnYlNvcmhJc3JPMkN2OWt5V0F5S2xG?=
 =?utf-8?B?Z3c1UnMzU3h2Y2xtQldOUEJJYURTWi9oWHRnQ1ZhQXAxYmVuSU03cUE1Nzc3?=
 =?utf-8?B?aE9uZVJtQysrUUxMVlZKV0N3TzM4ZWlLVFlCVVVlVklkNTlSd0I0dUwrSll0?=
 =?utf-8?B?VUtaMmM1ZXI5VzhSWWdhdk56ZHh4UkR6dXU4am1GZDZoUDdyK1BXbEhpd3Uv?=
 =?utf-8?B?MW1jTW5adzhnMmg1RVdiV3FGM2pnWWsvNjZBd3BKUWdMSGpldlFDb29NeVpw?=
 =?utf-8?B?dzIyR2FVa2hkSXFKYkJPU0VjbDVrTVNrUDlqaG02RlZVdHdBcEpsd3B1L2dZ?=
 =?utf-8?B?YUEzZjhvdkRpcmRSc2NTVzlnUW13blNqcVRMT3dUZTdwNlVzcnZRZWkwZitF?=
 =?utf-8?B?cUVmYXpSY00rN0VzaC9hTG10M0R0bllCNERyeDdueDUxbkFFdUE1UWR4ZzZY?=
 =?utf-8?B?endZQmJXRGE4Q3cyWlNQVzc5Ky9iTkhkZTErMG1rdHEwdFlEc3ZLWk8wSGV2?=
 =?utf-8?B?ZW0wd2EzYkdycUIxamlkQlE0YTd4eVorUWQrSmZTdWU5OXEzdEY4blFZMTlF?=
 =?utf-8?B?dzB6c1hyK1IrZjhVb09pUThNWGNJUnVGMllxcE9vTGQ3M01ac2h4T1hBcE1W?=
 =?utf-8?B?cnNqTzJqNk5lTXo2T0EzdUlkQzNxeVo1V0kxR1NyQUhwRGFONVg4YjlEKzJW?=
 =?utf-8?B?Q2JHbmN5T21OZlRGVXE2Qm1tc1pmbGNKbVZEdjAveXdMNDFla2dVQmpQK2Na?=
 =?utf-8?B?ZTd6dTUrQnFpdDBUV2pFZTlaVGFtUTNFUFpoQUZnclQyUGYrbFhyVmxldGpB?=
 =?utf-8?B?Q0dpL09saUEyN3RlNnQrVkNTZ2lIQWk1dy95Z1BDSmxPT0ZCZFBSdkxhdCtI?=
 =?utf-8?B?ak5VZ2hLQU1zeXNJaUpKNGNpUDcrSk9oc05ib1FJZUZhbXhoYmorSE16dVIy?=
 =?utf-8?B?WkNGRFFsVTZsN2IzU2RSS2dKV2wxYW4zM3J5R2hsMTNSRzRoRGo0VzRCZnYy?=
 =?utf-8?B?bExHOGc5N1NvRitnMmw4OEU4eVNtS3dpdFE0blVyeW1rZDI4cFdpd2c3SXpT?=
 =?utf-8?B?MHMyNkZZMFgzelFXd1hRNnhLZGJLa3REWDlDbFFKSktIa1doUVJEM3ZsRExx?=
 =?utf-8?B?R1dpVElMWWVlVnRPdW9ITzBuOEVYS3U2ZmduS3pmUXpWWjZDTDdqTFpGM0N2?=
 =?utf-8?B?L2F0VTZScTA1V0Y5QWliSnN2VmpkN05BdHJkRXNNK0VjVU5qREFOeCtVRFc5?=
 =?utf-8?B?M1pPZEtiMS9uV1BEWkMzTjIzRWM2Uld6Q2ljbVQ4SW1hdFRPZGQrcUdrQzg4?=
 =?utf-8?B?U2RZeFpuTUZ4ZTdMV281SVYvYVVNOWRSRWtVTzkzTUc3Z0dJYWt3K3JHYUsx?=
 =?utf-8?B?bUNwQlhSY2E4K2gzbk1FZ2lVRUYwemJCN09SWUVid21ibmw0VHYwY1dxVGtP?=
 =?utf-8?B?Q0pjV0lhY3FpbmZtMm9JYjd1V09TRDVmNHRoTGZZREswYmxxcWJkV2dqWUtj?=
 =?utf-8?B?aWgrZnVlWHVhNHhIeE5jakw0bFlCb3VrWWZTS2tuaDJuS0ZpU2tnVzg4cVds?=
 =?utf-8?B?eUliQlNtUUlYdHFUb0FDZ09Za284RUpTTjhGeElCakFZNnRpT1FOYlFSNkVV?=
 =?utf-8?B?c2RzQnZvMHhhQjBFVVVkZXRIdlpEbEFudXZjWktIMHJiRDBSTW5kR2pPRzlB?=
 =?utf-8?B?elpIYVE4ZzUyNEl0dTV3NFA0ZWJjenNWT2FPZy9MQlY3M0FjNHZ6d3Fid2JE?=
 =?utf-8?B?cjk4MXpyVmsrNTBjNzNVUW0yTzNEQWJjNFZVRzJnUU9OVGJqZzVWSW1YL3hB?=
 =?utf-8?B?TE42cjg5ZFQrS1hWRGdVVUMxV0FTdmg2d3VlMUlvcm9FUnJvc3dIUDhxTkxo?=
 =?utf-8?B?OVRRbzRBUG40TC9EaENmS1pRTUxGUWllYytzV3JSRExHR2NrN1FmaStwdGxQ?=
 =?utf-8?B?VklGS202UmRleDQyNjI3WVNPek1HVUlNMEtMN0dBbGd6RUVVRXppTjZ6MEJ5?=
 =?utf-8?B?QWFWMDVlY3dod3hGU3ovd2NPSlg2Z0dSY29WUGdRMU1Vd3NndmZDWHkwM2Zq?=
 =?utf-8?B?RG5ZaTNCMjA5R2JYNlNvV1pKbGR1VEdnQ08zQmlONkM4NUo1N1JYUUxQcStR?=
 =?utf-8?Q?+GvE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5acff3a-2b5c-409f-4652-08dbc90923af
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:48:49.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+tRks7ZBTuP/+M7L+qc3ixfPRN1zziyamFeCRzaNbE3R9WSfjW9Nh5fP9u4uMEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/10 02:30, Johannes Thumshirn wrote:
> In case we're scrubbing a filesystem which uses the RAID stripe tree for
> multi-device logical to physical address translation, perform an extra
> block mapping step to get the real on0disk stripe length from the stripe
> tree when scrubbing the sectors.
> 
> This prevents a double completion of the btrfs_bio caused by splitting the
> underlying bio and ultimately a use-after-free.

My concern is still the same, why we hit double endio calls in the first 
place?

In the bio layer, if the bbio->inode is NULL, the real endio would only 
be called when all the split bios finished, thus it doesn't seem to 
cause double endio calls.

Mind to explain it more?
> 
> Cc: Qu Wenru <wqu@suse.com>
> Fixes: 0708614f9c28 ("btrfs: scrub: implement raid stripe tree support")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/scrub.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c477a14f1281..2ac574bde350 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1640,6 +1640,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
>   {
>   	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
>   	struct btrfs_bio *bbio = NULL;
> +	u64 stripe_len = BTRFS_STRIPE_LEN;
>   	int mirror = stripe->mirror_num;
>   	int i;
>   
> @@ -1651,8 +1652,9 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
>   
>   		/* The current sector cannot be merged, submit the bio. */
>   		if (bbio &&
> -		    ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
> -		     bbio->bio.bi_iter.bi_size >= BTRFS_STRIPE_LEN)) {
> +		    ((i > 0 &&
> +		      !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
> +		     bbio->bio.bi_iter.bi_size >= stripe_len)) {
>   			ASSERT(bbio->bio.bi_iter.bi_size);
>   			atomic_inc(&stripe->pending_io);
>   			btrfs_submit_bio(bbio, mirror);
> @@ -1660,10 +1662,26 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
>   		}
>   
>   		if (!bbio) {
> +			struct btrfs_io_stripe io_stripe = {};
> +			struct btrfs_io_context *bioc = NULL;
> +			const u64 logical = stripe->logical +
> +					    (i << fs_info->sectorsize_bits);
> +			int err;
> +
>   			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
>   					       fs_info, scrub_read_endio, stripe);
> -			bbio->bio.bi_iter.bi_sector = (stripe->logical +
> -				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
> +			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
> +
> +			io_stripe.is_scrub = true;
> +			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
> +					      &stripe_len, &bioc, &io_stripe,
> +					      &mirror);

Another thing is, I noticed that for zoned devices, we still go through 
the repair path, just skip the writeback and rely on relocation to repair.

In that case, would scrub_stripe_submit_repair_read() need the same 
treatment or can be completely skipped instead?

Thanks,
Qu
> +			btrfs_put_bioc(bioc);
> +			if (err) {
> +				btrfs_bio_end_io(bbio,
> +						 errno_to_blk_status(err));
> +				return;
> +			}
>   		}
>   
>   		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
