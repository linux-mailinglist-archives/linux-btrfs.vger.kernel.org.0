Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94E222603A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGTM4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 08:56:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:58157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgGTM4P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 08:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595249773;
        bh=i5LHZobe5Jd9xjhkomHsX5c8BvnArQma69NUIvMXkdw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cnOXpwXmXnRRrwM/fB5exVi8T3eTA751M1yqTciGNSshH3SXq6XnJ5BDVH4xGSAD0
         B6iF03r26oljwW/xH0VXz+kGX3xOn3W5X8Nm7xwkGv8YuMi2/hgPm+Zp+tu/CN6+kb
         kOP3GMYjL6HHSTfhUwX9Nz6ddxpjw4fJvRR1IUj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1kBrKS1Y7g-00PJCr; Mon, 20
 Jul 2020 14:56:13 +0200
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Christian Zangl <coralllama@gmail.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
 <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
 <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
 <b49c8f68-5897-7bc1-21d5-03125e798a76@gmx.com>
 <409fb0aa-7c7f-db52-6442-d746b9944fa3@gmail.com>
 <46ea54ea-3ed3-f1b7-7314-a69f4195c8f9@gmx.com>
 <8678a4f9-3388-5a7b-00cc-8b9da6a0a6e8@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <acbe2fee-1462-7631-22cc-19af58da8b57@gmx.com>
Date:   Mon, 20 Jul 2020 20:56:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8678a4f9-3388-5a7b-00cc-8b9da6a0a6e8@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CM5MCdtyIkqyUMfzoeXkputVDO3kRf72s"
X-Provags-ID: V03:K1:i3XA89yScQTsq5YMPQBgdrJuZSKWxbznnjeLf6aS30ohRmYcvf6
 lJ5goyv715R1Pr9Noc4CAi/tR52gIwnet4pMR7rYfnbHIhnjnkUQYNI9z1SA0+8Cll2tner
 I6Gz38R8PfUNqbN8TYuC3uA8fEulPUQU9XCABdRFgcXUCNrJdcsCjQFaXoRRPAomLCppHJC
 UDwYIppIyqwGhF9Jhz+WA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:au0MmQmztoc=:8WNaQNsnijEpl310cPy9rw
 YVxRHtG+96jT9bM5njInZ3K787qpsyihPRyV24IGadws8AbZ8gvplu+cXFbvUVIwUl+bUbrVy
 b65ZLErs6ZRqdTZ88kEheG6VhnvI71syAOMo7uOIYunAjiAGrwexur39emMLAMAuOqn9TMg4q
 T0Pq2IESzkasNf8qP8E7QSsfs8i/AvLZISaZoGsWdzq9gMKOgLcP/SnAWsoDaI5P5NzrkZX+R
 cNChyMf2ReDpZiA/JaJVmyeHch7lIU8K8jfTQquRXcLdHAc/ttoNX5V5aag+8fNL4NdrSPohL
 WTHBcMzFmQqn/RUwxgmATiv094zTJyNQ6dH8bKRlG4aqhLQSIO0lUeFbuxsdb8qMWhqM5iRHt
 s52/1MxxZ7lgTkRlwA8WmKF+0HUy2XZ4aXWJm3zU4szf6UWDsBepiKahYDbIWXmXj7OmENMMK
 FxeJnx+kE4R09fTKf53DSPd4mRlOXEfvOHcf7s3p10680kLD4MQU35nwuZGNC6nPDFsOjSaa1
 ffBKVP1G2v6Z5FQeARfJyUF1UDfs1T7LKPyynHfFftIL/qxu+NbWF85Gh20XMLiYEL3lmG2Tk
 qRN6C+7smuWlunl49slG9fVolC3Bp+cmRSfAG0ZuHB1QVGIEsk9jCl3p+eVbEMSv6MbK52Hg3
 w8B3RwAwTxAVfvxDhbli2ifBmtlaaIKSxeoU1BqMCWib9fhap1mlWYXWfbt26pkdtqxS9a27x
 vVINr4hl00erv6VKrJyruJRHUGDBuFbbk5gzwlt8tt3xltTW8XXEazd9rawoPFFimmQsc9PM/
 bfir/WCw050AH75rqYRMkxVQ6vsLlFZzvgjo8rf0VgccbEA8Pq4muGKVIruYupJrSck1+VdCR
 nfXlwCtIwBZvcG1JRLtubZRRvs66bM6LBdOtyj36tgroKdSJtpd80UnanMjUpPbXSBvVQsRSh
 E2zJuRas9GZHS/6YIRoZM4vWYkFXwYJm1fOp6y2mPUMBFxM0ZkAzZyoP5YBjqZX2ix12GA45d
 iNlUxVq00Vy4nYYCkVLGtD5dcncBPtX/tHC5mExqXXllan6F1fQ470hSMmp/H2wiKSYnSOioB
 SEI5+Cx9+ZwPjNxPoJdyFlT8SKiHT97XRSa3Yw4oewNLLVIg2/eWRWCnwc8XkdXBo9aXVPGeb
 rY3cqlb7+LKExKjGHM+v6pCZAstfhQL1IZEYSvj/Dt5Tnr9MSRwtR1WSevJ1sevXjEON5YRj1
 WlRfulM6q6uYzeuDdBJLfoQ/kB1lO5mgci0BguA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CM5MCdtyIkqyUMfzoeXkputVDO3kRf72s
Content-Type: multipart/mixed; boundary="2r6EbAhw6HTP11iF7Rru7tijxiD9V69GH"

--2r6EbAhw6HTP11iF7Rru7tijxiD9V69GH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Thanks for your detailed report.

Now we have pinned down the bug, it's a bit overflow for multiplying
unsigned int.

At least not some fundamental design defeat of btrfs-convert.

The fix has been Cced to you, and passed my local test.
Test case has also been submitted.

Thanks again for your help!
Qu


--2r6EbAhw6HTP11iF7Rru7tijxiD9V69GH--

--CM5MCdtyIkqyUMfzoeXkputVDO3kRf72s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8VlGgACgkQwj2R86El
/qhIMggArHt8H0VHIXgj/32xaVxbg4UrdatNq4Ej7cZHAaFEBC6lX6SXnP7Q2iZJ
QeSlS/7/lVkKS3LGaLxQAzU1WiN/xsWbeft79SxRMAl8e3Q7gJLXIXdXfYdt1trF
QwDAK73T0nPI94y6Cu/P30l4A47BTZFqkaolLns+bE9E7jMSbAFh25sz5S4O3H0q
IO8Cio4Ur+sksxAURJTJiBbYdN2LtBoKh7B0VZ0TdTIDqhHLKpOcEb2AKIwXE4HH
oNF75VDWq1E0O/+rnJAUIddPMvcCU62cdgarADNsrTDJnr+JQosjMu515ikdLHFH
u1tMIBNv6pcPm/4Ghfu1LIvYFE7EPw==
=tdtT
-----END PGP SIGNATURE-----

--CM5MCdtyIkqyUMfzoeXkputVDO3kRf72s--
